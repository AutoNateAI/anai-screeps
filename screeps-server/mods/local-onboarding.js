const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');

module.exports = config => {
  if (!config.backend) return;

  config.backend.welcomeText = '<h4>Welcome to your AutoNateAI Screeps local server!</h4><p>Create or choose a local profile at <a href="/local/">/local</a>, then connect with the Screeps: World client at <code>localhost:21025</code>.</p>';

  config.backend.on('expressPreConfig', app => {
    const { db } = config.common.storage;
    const router = express.Router();

    router.use(express.static(path.join(__dirname, 'local-onboarding')));

    router.get('/api/profiles', async (_req, res) => {
      try {
        const users = await db.users.find(
          {},
          {
            username: 1,
            email: 1,
            password: 1,
            cpu: 1,
            gcl: 1,
            registeredDate: 1,
            active: 1
          }
        );
        const systemUsers = new Set(['CaptureBot', 'Invader', 'Screeps', 'Source Keeper']);
        const profiles = users
          .filter(user => user.password && !systemUsers.has(user.username))
          .sort((a, b) => String(a.username || '').localeCompare(String(b.username || '')));
        res.json({
          ok: 1,
          profiles: profiles.map(user => ({
            id: user._id,
            username: user.username,
            email: user.email,
            cpu: user.cpu,
            gcl: user.gcl,
            active: user.active !== 0,
            registeredDate: user.registeredDate
          }))
        });
      } catch (error) {
        res.status(500).json({ error: error.stack || error.message || String(error) });
      }
    });

    router.post('/api/register', bodyParser.json(), async (req, res) => {
      try {
        const body = req.body || {};
        const username = String(body.username || '').trim();
        const email = String(body.email || `${username}@local`).trim();
        const password = String(body.password || '');

        if (!/^[A-Za-z0-9_-]{3,32}$/.test(username)) {
          return res.status(400).json({ error: 'Username must be 3-32 letters, numbers, underscores, or dashes.' });
        }
        if (password.length < 4) {
          return res.status(400).json({ error: 'Password must be at least 4 characters.' });
        }

        const existing = await db.users.findOne({ $or: [{ username }, { email }] });
        if (existing) return res.status(409).json({ error: 'Username or email already exists.' });

        const { preventSpawning, registerCpu } = config.auth.config;
        const hashed = await config.auth.hashPassword(password);
        let user = {
          username,
          usernameLower: username.toLowerCase(),
          email,
          cpu: registerCpu,
          cpuAvailable: 0,
          registeredDate: new Date(),
          blocked: !!preventSpawning,
          money: 0,
          gcl: 0,
          salt: hashed.salt,
          password: hashed.pass
        };

        user = await db.users.insert(user);
        await db['users.code'].insert({
          user: user._id,
          modules: { main: '' },
          branch: 'default',
          activeWorld: true,
          activeSim: true
        });
        await config.common.storage.env.set(`scrUserMemory:${user._id}`, JSON.stringify({}));

        res.json({ ok: 1, profile: { id: user._id, username, email, cpu: user.cpu, gcl: user.gcl } });
      } catch (error) {
        res.status(500).json({ error: error.stack || error.message || String(error) });
      }
    });

    app.use('/local', router);
  });
};

const bodyParser = require('body-parser');
const vm = require('vm');

/**
 * Adds a local-only HTTP endpoint that triggers the server's own NPC invader
 * generation for a room, so combat tutorials (docs/tutorials/07-defense.md,
 * 12-pvp-fundamentals.md, 13-sparring-ground.md) can be tested repeatedly
 * without clicking through the client's Invasion panel each time, and
 * without any dependency on Steam or an internet connection.
 *
 * This does not invent a creep document from scratch. It reuses the same
 * mechanism the real engine uses to decide a room is "due" for an invasion
 * (a room's invaderGoal/invaderHarvested counters, documented at
 * https://wiki.screepspl.us/Private_Server_Common_Tasks/), then asks the
 * engine's own genInvaders cronjob to act on that — the same command a
 * server admin would type into the CLI by hand. The CLI sandbox this reuses
 * (config.cli.createSandbox) is the same one screeps-launcher-cli.js already
 * wires up in this repo.
 *
 * If this ever stops matching the installed engine version's behavior, the
 * manual fallback is the client's own Invasion panel (room side panel >
 * Invasion > Create an invader > click an exit tile) — that always works
 * because it's a first-party client feature, not something this mod infers.
 */
module.exports = config => {
  if (!config.backend || !config.cli) return;

  config.backend.on('expressPreConfig', app => {
    const { db } = config.common.storage;

    app.post('/local/api/sparring/wave', bodyParser.json(), async (req, res) => {
      const room = String((req.body && req.body.room) || '').trim();
      if (!room) {
        return res.status(400).json({ error: 'Provide a "room" name in the request body.' });
      }

      try {
        const roomDoc = await db.rooms.findOne({ _id: room });
        if (!roomDoc) {
          return res.status(404).json({ error: `No room found with name "${room}".` });
        }

        // Force this room's invasion counter to look already-due, then ask
        // the engine's real cronjob to evaluate every room and spawn where
        // eligible. This only produces an invader if the room still has at
        // least one exit into a neutral, unclaimed room — same restriction
        // the automatic energy-triggered version has.
        const output = [];
        const ctx = vm.createContext(config.cli.createSandbox(line => output.push(line)));
        const command = `
          storage.db.rooms.update({ _id: '${room}' }, { $set: { invaderGoal: 0, invaderHarvested: 1 } })
            .then(() => system.runCronjob('genInvaders'))
            .then(() => 'genInvaders cronjob completed for ${room}')
        `;
        const result = await vm.runInContext(command, ctx);

        res.json({ ok: 1, room, result: String(result), log: output });
      } catch (error) {
        res.status(500).json({ error: error.stack || error.message || String(error) });
      }
    });

    app.get('/local/api/sparring/health', (_req, res) => {
      res.json({ ok: 1, message: 'sparring-ground mod is loaded' });
    });
  });
};

#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

const root = process.cwd();

function patchFile(relativePath, replacements) {
  const filePath = path.join(root, relativePath);
  let source = fs.readFileSync(filePath, 'utf8');
  let patched = source;

  for (const [from, to] of replacements) {
    if (!patched.includes(from)) {
      if (patched.includes(to)) {
        continue;
      }
      console.warn(`${relativePath}: patch target not found, skipping one replacement`);
      continue;
    }
    patched = patched.replace(from, to);
  }

  if (patched === source) {
    console.log(`${relativePath}: already patched`);
    return;
  }

  fs.writeFileSync(filePath, patched);
  console.log(`${relativePath}: patched`);
}

patchFile('screeps-server/node_modules/@screeps/backend/lib/game/server.js', [
  [
`    const localPasswordAuthOnly = process.env.SCREEPS_LOCAL_PASSWORD_AUTH_ONLY === '1';

    if (process.env.STEAM_KEY) {
        console.log("STEAM_KEY environment variable found, disabling native authentication");
        useNativeAuth = false;
    }
    else if (localPasswordAuthOnly) {
        console.log("SCREEPS_LOCAL_PASSWORD_AUTH_ONLY is set, skipping Steam authentication startup");
        useNativeAuth = false;
    }
    else {
        console.log("STEAM_KEY environment variable is not found, trying to connect to local Steam client");
        try {
            greenworks = require('../../greenworks/greenworks');
        }
        catch(e) {
            throw new Error('Cannot find greenworks library, please either install it in the /greenworks folder or provide STEAM_KEY environment variable');
        }
        if (!greenworks.isSteamRunning()) {
            throw new Error('Steam client is not running');
        }
        if (!greenworks.initAPI()) {
            throw new Error('greenworks.initAPI() failure');
        }
        useNativeAuth = true;
    }

    return (useNativeAuth || localPasswordAuthOnly ? q.when() : connectToSteam()).then(() => {
`,
`    const localPasswordAuthOnly = process.env.SCREEPS_LOCAL_PASSWORD_AUTH_ONLY === '1';

    if (localPasswordAuthOnly) {
        console.log("SCREEPS_LOCAL_PASSWORD_AUTH_ONLY is set, skipping Steam authentication startup");
        useNativeAuth = false;
    }
    else if (process.env.STEAM_KEY) {
        console.log("STEAM_KEY environment variable found, disabling native authentication");
        useNativeAuth = false;
    }
    else {
        console.log("STEAM_KEY environment variable is not found, trying to connect to local Steam client");
        try {
            greenworks = require('../../greenworks/greenworks');
        }
        catch(e) {
            throw new Error('Cannot find greenworks library, please either install it in the /greenworks folder or provide STEAM_KEY environment variable');
        }
        if (!greenworks.isSteamRunning()) {
            throw new Error('Steam client is not running');
        }
        if (!greenworks.initAPI()) {
            throw new Error('greenworks.initAPI() failure');
        }
        useNativeAuth = true;
    }

    return (useNativeAuth || localPasswordAuthOnly ? q.when() : connectToSteam()).then(() => {
`
  ],
  [
`    if (process.env.STEAM_KEY) {
        console.log("STEAM_KEY environment variable found, disabling native authentication");
        useNativeAuth = false;
    }
    else {
        console.log("STEAM_KEY environment variable is not found, trying to connect to local Steam client");
        try {
            greenworks = require('../../greenworks/greenworks');
        }
        catch(e) {
            throw new Error('Cannot find greenworks library, please either install it in the /greenworks folder or provide STEAM_KEY environment variable');
        }
        if (!greenworks.isSteamRunning()) {
            throw new Error('Steam client is not running');
        }
        if (!greenworks.initAPI()) {
            throw new Error('greenworks.initAPI() failure');
        }
        useNativeAuth = true;
    }

    return (useNativeAuth ? q.when() : connectToSteam()).then(() => {
`,
`    const localPasswordAuthOnly = process.env.SCREEPS_LOCAL_PASSWORD_AUTH_ONLY === '1';

    if (localPasswordAuthOnly) {
        console.log("SCREEPS_LOCAL_PASSWORD_AUTH_ONLY is set, skipping Steam authentication startup");
        useNativeAuth = false;
    }
    else if (process.env.STEAM_KEY) {
        console.log("STEAM_KEY environment variable found, disabling native authentication");
        useNativeAuth = false;
    }
    else {
        console.log("STEAM_KEY environment variable is not found, trying to connect to local Steam client");
        try {
            greenworks = require('../../greenworks/greenworks');
        }
        catch(e) {
            throw new Error('Cannot find greenworks library, please either install it in the /greenworks folder or provide STEAM_KEY environment variable');
        }
        if (!greenworks.isSteamRunning()) {
            throw new Error('Steam client is not running');
        }
        if (!greenworks.initAPI()) {
            throw new Error('greenworks.initAPI() failure');
        }
        useNativeAuth = true;
    }

    return (useNativeAuth || localPasswordAuthOnly ? q.when() : connectToSteam()).then(() => {
`
  ]
]);

patchFile('screeps-server/node_modules/@screeps/backend/lib/game/api/auth.js', [
  [
`router.post('/steam-ticket', jsonResponse(request => {

    var doAuth;
`,
`router.post('/steam-ticket', jsonResponse(request => {

    if (process.env.SCREEPS_LOCAL_PASSWORD_AUTH_ONLY === '1') {
        const username = process.env.SCREEPS_LOCAL_DEFAULT_USER || 'autonate';
        return db.users.findOne({username})
        .then(user => {
            if (!user) {
                return q.reject('local default user not found: ' + username);
            }
            console.log(\`Local client sign in: \${user.username} (\${user._id}), IP=\${request.ip}\`);
            return authlib.genToken(user._id)
            .then(token => ({token, steamid: 'local-' + user._id}));
        });
    }

    var doAuth;
`
  ],
  [
`        steam: _.pick(request.user.steam, ['id', 'displayName', 'ownership','steamProfileLinkHidden']),
`,
`        steam: _.pick(request.user.steam || {}, ['id', 'displayName', 'ownership','steamProfileLinkHidden']),
`
  ]
]);

patchFile('screeps-server/node_modules/screepsmod-auth/lib/backend.js', [
  [
`    allowRegistration: !process.env.SERVER_PASSWORD,
    steam: true
`,
`    allowRegistration: !process.env.SERVER_PASSWORD,
    steam: process.env.SCREEPS_LOCAL_PASSWORD_AUTH_ONLY !== '1'
`
  ],
  [
`  require('./register')(config)
  require('./steam')(config)
  require('./github')(config)
`,
`  require('./register')(config)
  if (process.env.SCREEPS_LOCAL_PASSWORD_AUTH_ONLY !== '1') require('./steam')(config)
  require('./github')(config)
`
  ]
]);

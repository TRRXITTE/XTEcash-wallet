const path = require('path');

const extraNodeModules = {
  'crypto': path.resolve(__dirname, 'node_modules/react-native-crypto'),
  'stream': path.resolve(__dirname, 'node_modules/stream-browserify'),
  'http': path.resolve(__dirname, 'node_modules/@tradle/react-native-http'),
  'https': path.resolve(__dirname, 'node_modules/https-browserify'),
  'net': path.resolve(__dirname, 'node_modules/react-native-tcp'),
  'path': path.resolve(__dirname, 'node_modules/path-browserify'),
  'zlib': path.resolve(__dirname, 'node_modules/browserify-zlib'),
  'console': path.resolve(__dirname, 'node_modules/console-browserify'),
  'vm': path.resolve(__dirname, 'node_modules/vm-browserify'),
  'process': path.resolve(__dirname, 'node_modules/process'),
  'buffer': path.resolve(__dirname, 'node_modules/buffer'),
  'fs': path.resolve(__dirname, 'node_modules/react-native-level-fs'),
  'dgram': path.resolve(__dirname, 'node_modules/react-native-udp'),
  'assert': path.resolve(__dirname, 'node_modules/assert'),
  'querystring': path.resolve(__dirname, 'node_modules/querystring-es3'),
  'url': path.resolve(__dirname, 'node_modules/url'),
  'tls': path.resolve(__dirname, 'shims/tls.js'),
};

module.exports = {
  transformer: {
    getTransformOptions: async () => ({
      transform: {
        experimentalImportSupport: false,
        inlineRequires: true,
      },
    }),
  },
  resolver: {
    extraNodeModules,
  },
};

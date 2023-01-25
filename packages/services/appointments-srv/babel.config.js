module.exports = {
  presets: [
    '@babel/preset-env',
    '@babel/preset-typescript',
  ],
  plugins: [
      'module-resolver',
      'transform-decorators-legacy',
      '@babel/plugin-transform-typescript',
      '@babel/plugin-proposal-decorators',
      'babel-plugin-transform-typescript-metadata',
      {
        alias: {
          '@domain': './src/domain',
          '@infra': './src/infra',
          '@main': './src/main',
        },
      },
    '@babel/plugin-proposal-class-properties',
  ],
}
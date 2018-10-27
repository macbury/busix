const webpack = require('webpack')

const { environment, config } = require('@rails/webpacker')
const { resolve } = require('path')

const HtmlWebpackPlugin = require('html-webpack-plugin')
const HtmlWebpackHarddiskPlugin = require('html-webpack-harddisk-plugin')
const AutoDllPlugin = require('autodll-webpack-plugin')
const CleanWebpackPlugin = require('clean-webpack-plugin')
const FlowtypePlugin = require('flowtype-loader/plugin');

const typescript = require('./loaders/typescript')
environment.loaders.append('typescript', typescript)

environment.config.merge({
  resolve:{
    alias: {
      '~styles': resolve('app/javascript/packs/styles'),
      '~containers': resolve('app/javascript/packs/containers'),
      '~pages': resolve('app/javascript/packs/pages'),
      '~actions': resolve('app/javascript/packs/actions'),
      '~reducers': resolve('app/javascript/packs/reducers'),
      '~components': resolve('app/javascript/packs/components'),
      "./images/": resolve("./node_modules/leaflet/dist/images/")
    }
  }
})

environment.plugins.append('html',
  new HtmlWebpackPlugin({
    inject: 'body',
    alwaysWriteToDisk: true,
    filename: '../main.html',
    template: resolve('app', 'javascript', 'index.html')
  })
)


// environment.plugins.append('dll', 
//   new AutoDllPlugin({
//     debug: true,
//     inherit: false,
//     inject: true, // will inject the DLL bundles to index.html
//     filename: '[name].dll.js',
//     path: './dll',
//     entry: {
//       vendor: [
//         'react',
//         'react-dom',
//         'graphiql',
//         'react-redux',
//         'redux',
//         'prop-types',
//         'react-router-dom',
//         'react-router',
//         'connected-react-router',
//         'redux-thunk',
//         'antd',
//         'i18n-js',
//         'graphql-request',
//         'graphql-tag',
//         'graphql',
//         'redux-actions-generator',
//         'leaflet',
//         'react-leaflet'
//       ]
//     }
//   })
// )

environment.loaders.append('less', {
  test: /\.less$/,
  use: [{
    loader: 'style-loader',
  }, {
    loader: 'css-loader', // translates CSS into CommonJS
  }, {
    loader: 'less-loader',
    options: {
      javascriptEnabled: true
    }
  }],
  // ...other rules
})

environment.loaders.append('mjs', {
  test: /\.mjs$/,
  include: /node_modules/,
  type: "javascript/auto",
})

environment.plugins.append('fuckFlow', new webpack.ContextReplacementPlugin(/graphql-language-service-interface[\/\\]dist/, /\.js$/))
environment.plugins.append('hardisk', new HtmlWebpackHarddiskPlugin())
//environment.plugins.append('cleanup', new CleanWebpackPlugin(['public/index.html', 'public/packs']))

const webpackConfig = environment.toWebpackConfig()

module.exports = {
  ...webpackConfig,
  target: 'web',
  entry: resolve('app/javascript/packs/application.tsx')
}

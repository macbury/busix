const webpack = require('webpack')

const { environment, config } = require('@rails/webpacker')
const { resolve } = require('path')

const HtmlWebpackPlugin = require('html-webpack-plugin')
const HtmlWebpackHarddiskPlugin = require('html-webpack-harddisk-plugin')
const AutoDllPlugin = require('autodll-webpack-plugin')

const typescript = require('./loaders/typescript')
environment.loaders.append('typescript', typescript)

environment.config.merge({
  resolve:{
    alias: {
      '~styles': resolve('app/javascript/packs/styles'),
      '~containers': resolve('app/javascript/packs/containers'),
    }
  }
})

environment.plugins.append('html',
  new HtmlWebpackPlugin({
    inject: 'body',
    alwaysWriteToDisk: true,
    filename: '../index.html',
    template: resolve('app', 'javascript', 'index.html')
  })
)

environment.plugins.append('dll', 
  new AutoDllPlugin({
    inject: true, // will inject the DLL bundles to index.html
    filename: '[name]_[hash].dll.js',
    path: './libs/',
    entry: {
      vendor: [
        'react',
        'react-dom',
        'graphiql',
        'react-redux',
        'redux',
        'prop-types',
        'react-router-dom',
        'react-router',
        'connected-react-router',
        'redux-thunk',
        'antd'
      ]
    }
  })
)

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


environment.plugins.append('hardisk', new HtmlWebpackHarddiskPlugin())

const webpackConfig = environment.toWebpackConfig()

module.exports = {
  ...webpackConfig,
  target: 'web',
  entry: resolve('app/javascript/packs/application.tsx')
}
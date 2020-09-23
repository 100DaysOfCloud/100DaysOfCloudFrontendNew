const path = require('path')
const webpack = require('webpack')
const MiniCssExtractPlugin = require('mini-css-extract-plugin')

const coffee = {
  test: /\.coffee$/, loader: 'coffee-loader'
}

// https://blog.jakoblind.no/postcss-webpack/
const css = {
  test: /\.css$/,
  exclude: /node_modules/,
  use: [
    {
      loader: MiniCssExtractPlugin.loader
    },
    //'style-loader',
     {
       loader: 'css-loader',
       options: {
         importLoaders: 1
       }
     },
    'postcss-loader'
  ]
}

const namespace_application = {
  mode: 'development',
  target: 'web',
  entry: {
    'application.js' : path.resolve(__dirname, 'javascripts/application.coffee'),
    'application.css' : path.resolve(__dirname, 'stylesheets/application.css')
  },
  output: {
    path    : path.resolve(__dirname, '..', 'public'),
    filename: '[name]'
  },
  resolve: {
    extensions: ['.coffee','.js','.json'],
    modules: ['node_modules/'],
    alias: {
      components : path.resolve(__dirname, 'javascripts/components/'),
      models     : path.resolve(__dirname, 'javascripts/models/'),
      views      : path.resolve(__dirname, 'javascripts/views/'),
      services   : path.resolve(__dirname, 'javascripts/services/'),
      lib        : path.resolve(__dirname, 'javascripts/lib/'),
      dilithium  : path.resolve(__dirname, 'javascripts/lib/dilithium/dilithium'),
      config     : path.resolve(__dirname, 'config.js')
    }
  },
  node: { __dirname: false },
  plugins: [
    new MiniCssExtractPlugin({filename: 'application.css'})
  ],
  module : { rules: [coffee,css] }
}

module.exports = [
  namespace_application
]


require('~styles')

import * as React from 'react'
import * as ReactDOM from 'react-dom'

import Application from './application'
import { hot } from 'react-hot-loader'

const App = hot(module)(Application)

document.addEventListener('DOMContentLoaded', () => {
  const root = document.querySelector('#root')

  ReactDOM.render(<App />, root)
})

require('~styles')

import * as React from 'react'
import * as ReactDOM from 'react-dom'

import Application from '~containers/application'

document.addEventListener('DOMContentLoaded', () => {
  const root = document.querySelector('#root')
  ReactDOM.render(<Application></Application>, root)
})

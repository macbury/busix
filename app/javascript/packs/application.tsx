require('~styles')

import * as React from 'react'
import * as ReactDOM from 'react-dom'
import { Provider } from 'react-redux'
import { ConnectedRouter } from 'connected-react-router'
import { Route, Switch } from 'react-router-dom'

import Application from './containers/application'
import { store, history } from './reducers'

import ApiExplorer from './pages/ApiExplorer'

document.addEventListener('DOMContentLoaded', () => {
  const root = document.querySelector('#root')
  ReactDOM.render(
    <Provider store={store}>
      <ConnectedRouter history={history}>
        <Switch>
          <Route exact path="/" component={Application} />
          <Route exact path="/api/explorer" component={ApiExplorer} />
        </Switch>
      </ConnectedRouter>
    </Provider>, root
  )
})

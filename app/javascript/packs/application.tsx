require('~styles')

import * as React from 'react'
import * as ReactDOM from 'react-dom'
import { Provider } from 'react-redux'
import { ConnectedRouter } from 'connected-react-router'
import { Route, Switch } from 'react-router-dom'

import Application from './containers/application'
import AppWithTranslations from './containers/AppWithTranslations'

import { store, history } from './reducers'

import ApiExplorer from './pages/ApiExplorer'
import Departures from './pages/Departures'

document.addEventListener('DOMContentLoaded', () => {
  const root = document.querySelector('#root')

  ReactDOM.render(
    <AppWithTranslations>
      <Provider store={store}>
        <ConnectedRouter history={history}>
          <Switch>
            <Route exact path="/" component={Application} />
            <Route exact path="/departures" component={Departures} />
            <Route exact path="/api/explorer" component={ApiExplorer} />
          </Switch>
        </ConnectedRouter>
      </Provider>
    </AppWithTranslations>, root
  )
})

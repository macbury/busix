require('~styles')

import * as React from 'react'
import * as ReactDOM from 'react-dom'
import { Provider } from 'react-redux'
import { ConnectedRouter } from 'connected-react-router'
import { Route, Switch } from 'react-router-dom'

import AppWithTranslations from './containers/AppWithTranslations'

import { store, history } from './reducers'

import ApiExplorer from './pages/ApiExplorer'
import Schedules from './pages/Schedules'
import Directions from './pages/Directions'

document.addEventListener('DOMContentLoaded', () => {
  const root = document.querySelector('#root')

  ReactDOM.render(
    <AppWithTranslations>
      <Provider store={store}>
        <ConnectedRouter history={history}>
          <Switch>
            <Route exact path="/" component={Directions} />
            <Route exact path="/api/explorer" component={ApiExplorer} />
            <Route path={'/schedules/:currentLine/:currentDirection/:currentStop/:forDate'} 
                   component={Schedules}
                   exact />
            <Route path={'/schedules/:currentLine/:currentDirection/:currentStop'} 
                   component={Schedules}
                   exact />
            <Route path={'/schedules/:currentLine/:currentDirection'} 
                   component={Schedules}
                   exact />
            <Route path={'/schedules/:currentLine'} 
                   component={Schedules}
                   exact />
            <Route path={'/schedules'} 
                   component={Schedules}
                   exact />
          </Switch>
        </ConnectedRouter>
      </Provider>
    </AppWithTranslations>, root
  )
})

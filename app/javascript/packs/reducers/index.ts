import { createStore, combineReducers, applyMiddleware, compose } from 'redux'
import { connectRouter, routerMiddleware } from 'connected-react-router'

import thunkMiddleware from 'redux-thunk'
import createHistory from 'history/createBrowserHistory'

const composeEnhancers = (window as any).__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose

import { schedules, ISchedulesState } from './schedules'
import { ui, IUIState } from './ui'

export interface BusixState {
  schedules: ISchedulesState
  ui: IUIState
  router: {
    action : string,
    location : {
      pathname : string,
      key : string
    }
  }
}

const history = createHistory()
const reducers = combineReducers({
  schedules, ui
})

let middlewares = [
  routerMiddleware(history),
  thunkMiddleware
]

// if (process.env.NODE_ENV === 'development') {
//   const { logger } = require('redux-logger')

//   middlewares.push(logger)
// }

const store = createStore(connectRouter(history)(reducers), composeEnhancers(applyMiddleware(...middlewares)))

export { store, history }

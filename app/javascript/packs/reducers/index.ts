import { createStore, combineReducers, applyMiddleware, compose } from 'redux'
import { connectRouter, routerMiddleware } from 'connected-react-router'

import thunkMiddleware from 'redux-thunk'
import createHistory from 'history/createBrowserHistory'

const composeEnhancers = (window as any).__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose

import { schedules, ISchedulesState } from './schedules'

export interface BusixState {
  schedules: ISchedulesState
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
  schedules
})

const middlewares = applyMiddleware(
  routerMiddleware(history),
  thunkMiddleware
)

const store = createStore(connectRouter(history)(reducers), composeEnhancers(middlewares))

export { store, history }
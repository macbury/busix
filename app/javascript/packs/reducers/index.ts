import { createStore, combineReducers, applyMiddleware, compose } from 'redux'
import { connectRouter, routerMiddleware } from 'connected-react-router'

import thunkMiddleware from 'redux-thunk'
import createHistory from 'history/createBrowserHistory'

const composeEnhancers = (window as any).__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose

export interface BusixState {
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
  test: () => { return {} }
})

const middlewares = applyMiddleware(
  routerMiddleware(history),
  thunkMiddleware
)

const store = createStore(connectRouter(history)(reducers), composeEnhancers(middlewares))

export { store, history }
import { UI } from '~actions/index'

export interface IBreadcrumpItem {
  name : string
  path : string
}

export interface IUIState {
  collapse : boolean,
  breadcrumbs: Array<IBreadcrumpItem>
}

const INITIAL_STATE : IUIState = {
  collapse: true,
  breadcrumbs: []
}

export function ui(state = INITIAL_STATE, { type, payload }) : IUIState {
  switch (type) {
    case UI.TOGGLE_COLLAPSE:
      return {...state, collapse: !state.collapse}
    case UI.SET_BREADCRUMP:
      return {...state, breadcrumbs: payload}
  }
  return state
}

import { UI } from './index'
import { IBreadcrumpItem } from '~reducers/ui'

export function toggleSidebar() {
  return { type: UI.TOGGLE_COLLAPSE }
}

export function setBreadcrump(breadcrumbs : Array<IBreadcrumpItem>) {
  return { type: UI.SET_BREADCRUMP, payload: breadcrumbs }
}

export function clearBreadcrump() {
  return { type: UI.SET_BREADCRUMP, payload: [] }
}

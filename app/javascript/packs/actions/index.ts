import createActions from 'redux-actions-generator'

export const Schedules = createActions('schedules', [
  'START_FETCH',
  'FETCH_SUCCESS'
])

export const UI = createActions('ui', [
  'TOGGLE_COLLAPSE',
  'SET_BREADCRUMP'
])

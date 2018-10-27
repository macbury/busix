import createActions from 'redux-actions-generator'

export const Schedules = createActions('schedules', [
  'START_FETCH',
  'FETCH_SUCCESS',
  'SET_DIRECTIONS'
])

export const UI = createActions('ui', [
  'TOGGLE_COLLAPSE',
  'SET_BREADCRUMP',
  'SET_PAGE'
])

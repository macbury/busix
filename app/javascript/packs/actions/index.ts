import createActions from 'redux-actions-generator'

export const Schedules = createActions('schedules', [
  'START_FETCH',
  'FETCH_SUCCESS'
])
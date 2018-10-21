import { Schedules } from '~actions/index'

interface Line {
  name : string;
}

export enum Status {
  Empty,
  Loading,
  Success
}

export interface ISchedulesState {
  lines: Array<Line>
  trams: Array<Line>
  buses: Array<Line>
  status: Status
}

const INITIAL_STATE : ISchedulesState = {
  lines: [],
  trams: [],
  buses: [],
  status: Status.Empty
}

export function schedules(state : ISchedulesState = INITIAL_STATE, { type, payload }) : ISchedulesState {
  switch(type) {
    case Schedules.START_FETCH:
      return {...INITIAL_STATE, status: Status.Loading}
    case Schedules.FETCH_SUCCESS:
      let lines = payload
      return { ...state, status: Status.Success, lines }
  }
  return state
}
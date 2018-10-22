import { Schedules } from '~actions/index'

export interface Line {
  name : string;
  kind : string;
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
      return { 
        ...state, 
        status: Status.Success, 
        trams: lines.filter(({ kind }) => kind == 'tram'),
        buses: lines.filter(({ kind }) => kind == 'bus'),
        lines 
      }
  }
  return state
}

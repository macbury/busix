import { Schedules } from '~actions/index'

export interface IStop {
  id : number;
  name : string;
}

export interface IDirection {
  id : number;
  name : string;
  start : IStop;
  target : IStop;
  stops: Array<IStop>
}

export interface Line {
  id : number;
  name : string;
  kind : string;
  directions: Array<IDirection>
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
  directions: { [lineId : string] : Array<IDirection> }
  status: Status
}

const INITIAL_STATE : ISchedulesState = {
  lines: [],
  trams: [],
  buses: [],
  directions: {},
  status: Status.Empty
}

export function schedules(state : ISchedulesState = INITIAL_STATE, { type, payload }) : ISchedulesState {
  switch(type) {
    case Schedules.SET_DIRECTIONS:
      let line : Line = payload.line
      let directions = { ...state.directions }
      directions[line.name] = line.directions
      return {...state, directions }
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

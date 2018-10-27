import { Schedules  } from './index'

import { BusixState } from '~reducers/index'
import { query } from './graphql'

const FETCH_LINES_QUERY = `
  query($cursor: String) {
    lines(first: 100, after: $cursor) {
      pageInfo {
        endCursor
        hasNextPage
      }
      edges {
        node {
          name
          kind
        }
      }
    }
  }
`

async function fetchAllLines(cursor = '') {
  let { lines } = await query(FETCH_LINES_QUERY, { cursor })
  const { pageInfo, edges } = lines
  let nodes = edges.map(({ node }) => node)
  
  if (pageInfo.hasNextPage) {
    nodes = nodes.concat(await fetchAllLines(pageInfo.endCursor))
  }
  return nodes
}

export function fetchSchedules() {
  return async (dispatch, getState) => {
    let { schedules } : BusixState = getState()
    if (schedules.lines.length == 0) {
      dispatch({ type: Schedules.START_FETCH })
      let lines = await fetchAllLines()
      dispatch({ type: Schedules.FETCH_SUCCESS, payload: lines })
    }
  }
}

const FETCH_DIRECTIONS_QUERY = `
  query($line:String!){
    line(name: $line) {
      name
      directions {
        name
        start {
          name
        }
        target {
          name
        }
        stops {
          name 
        }
      }
    }
  }
`

export function fetchDirections(line) {
  return async (dispatch, getState) => {
    let response = await query(FETCH_DIRECTIONS_QUERY, { line })
    dispatch({ type: Schedules.SET_DIRECTIONS, payload: { line: response.line } })
  }
}


const FETCH_TIMETABLE_QUERY = `
  query($from: String!, $to: String!, $line: String!, $at: Time!, $cursor: String) {
    timetable(first: 100, after: $cursor, from: $from, to: $to, line: $line, at: $at) {
      pageInfo {
        hasNextPage
        endCursor
      }
      edges {
        node {
          time {
            date
          }
        }
      }
    }
  }
`

async function fetchAllTimetables(variables, cursor = '') {
  let { timetable } = await query(FETCH_TIMETABLE_QUERY, { ...variables, cursor })

  const { pageInfo, edges } = timetable
  let nodes = edges.map(({ node }) => node.time.date)
  
  if (pageInfo.hasNextPage) {
    nodes = nodes.concat(await fetchAllTimetables(variables, pageInfo.endCursor))
  }
  return nodes
}

export function fetchTimetable(line, from, to, at) {
  return async (dispatch, getState) => {
    let timetable = await fetchAllTimetables({ line, from, to, at })
    console.log(timetable)
    //dispatch({ type: Schedules.SET_DIRECTIONS, payload: { line: timetable.line } })
  }
}
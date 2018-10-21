import { Schedules  } from './index'
import { GraphQLClient } from 'graphql-request'
import { BusixState } from '~reducers/index'

const client = new GraphQLClient('/api/')

const FETCH_LINES = `
  query($cursor: String) {
    lines(first: 50, after: $cursor) {
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
  let { lines } = await client.request(FETCH_LINES, { cursor }) as any
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
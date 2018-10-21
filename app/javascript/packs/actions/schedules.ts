import { Schedules  } from './index'
import ApolloClient from 'apollo-boost';
import gql from 'graphql-tag'

const client = new ApolloClient({ uri: '/api' })

async function getTest() {
  const query = gql`
    {
      buses: lines(kind: BUS, first: 50) {
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
      
      trams: lines(kind: TRAM, first: 50) {
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

  let data = await client.query({
    query
  })

  console.log("Done")
  console.log(data)
}

export function fetchSchedules() {
  return async (dispatch, getState) => {
    // check if state schedules is not empty
    // if is fetch everything
    // else skip this action
    console.log(getState())
    await getTest()
    dispatch({ type: Schedules.FETCH })
  }
}
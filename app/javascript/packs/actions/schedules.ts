import { Schedules  } from './index'
import { GraphQLClient } from 'graphql-request'

const client = new GraphQLClient('/api/')

async function getTest() {
  const query = `
    {
      lines(first: 50) {
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

  const data = await client.request(query)
  console.log(data)
}

export function fetchSchedules() {
  return async (dispatch, getState) => {
    // check if state schedules is not empty
    // if is fetch everything
    // else skip this action
    //console.log(getState())
    await getTest()
    dispatch({ type: Schedules.FETCH })
  }
}
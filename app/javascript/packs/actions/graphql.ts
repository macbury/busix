import { GraphQLClient } from 'graphql-request'

export const client = new GraphQLClient('/api/')

export async function query(query, variables = {}) {
  try {
    let response = await client.request(query, variables) as any
    return response
  } catch (exception) {
    console.error(exception)
    return false
  }
}

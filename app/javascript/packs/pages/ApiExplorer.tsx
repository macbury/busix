import * as React from 'react'
import GraphiQL from 'graphiql'
import Application from '../containers/application'

function graphQLFetcher(graphQLParams) {
  return fetch(window.location.origin + '/api', {
    method: 'post',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(graphQLParams),
  }).then(response => response.json());
}

export default class ApiExplorer extends React.Component {
  render() {
    return (
      <Application><GraphiQL fetcher={graphQLFetcher} /></Application>
    )
  }
}
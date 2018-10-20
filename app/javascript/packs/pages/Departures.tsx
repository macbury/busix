import * as React from 'react'
import Application from '../containers/application'
import { Skeleton } from 'antd'

function graphQLFetcher(graphQLParams) {
  return fetch(window.location.origin + '/api', {
    method: 'post',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(graphQLParams),
  }).then(response => response.json());
}

export default class Departures extends React.Component<any> {
  render() {
    return (
      <Application>
        <Skeleton active loading />
      </Application>
    )
  }
}
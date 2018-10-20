import * as React from 'react'
import { Navbar, NavbarBrand } from 'reactstrap'
import GraphiQL from 'graphiql'

function graphQLFetcher(graphQLParams) {
  return fetch(window.location.origin + '/api', {
    method: 'post',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(graphQLParams),
  }).then(response => response.json());
}

export default class Application extends React.Component {
  render() {
    return (
      <div>
        <Navbar color="light" light>
          <NavbarBrand href="/">Busix</NavbarBrand>
        </Navbar>

        <div style={{ height: '960px' }}>
          <GraphiQL fetcher={graphQLFetcher} />
        </div>
      </div>
    )
  }
}
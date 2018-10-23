import * as React from 'react'
import GraphiQL from 'graphiql'
import Application from '../containers/application'
import { clearBreadcrump } from '~actions/ui'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'

function graphQLFetcher(graphQLParams) {
  return fetch(window.location.origin + '/api', {
    method: 'post',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(graphQLParams),
  }).then(response => response.json());
}

interface IApiExplorerProps {
  clearBreadcrump?()
}

class ApiExplorer extends React.Component<IApiExplorerProps> {
  componentDidMount() {
    this.props.clearBreadcrump()
  }
  
  render() {
    return (
      <Application>
        <GraphiQL fetcher={graphQLFetcher} />
      </Application>
    )
  }
}

function mapActionsToProps(dispatch) {
  return bindActionCreators({ clearBreadcrump }, dispatch)
}

export default connect(null, mapActionsToProps)(ApiExplorer)

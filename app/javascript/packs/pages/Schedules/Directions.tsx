import * as React from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom'
import { Skeleton } from 'antd'
import { bindActionCreators } from 'redux'

import { fetchDirections } from '~actions/schedules'
import { BusixState } from '~reducers/index'
import { Status, Line } from '~reducers/schedules'

interface IDirectionsProps {
  fetchDirections?(lineId)
  match?: {
    params: {
      lineId : string
    }
  }
}


class Directions extends React.Component<IDirectionsProps> {
  componentDidMount() {
    this.props.fetchDirections(this.lineId)
  }

  get lineId() : string {
    return this.props.match.params.lineId
  }

  componentDidUpdate(prevProps : IDirectionsProps) {
    if (this.lineId != prevProps.match.params.lineId) {
      this.props.fetchDirections(this.lineId)
    }
  }

  render() {
    return (
      <Skeleton active loading={true}>

      </Skeleton>
    )
  }
}

function mapActionsToProps(dispatch) : IDirectionsProps {
  return bindActionCreators({ fetchDirections }, dispatch)
}

function mapStateToProps({ schedules } : BusixState) : IDirectionsProps {
  return {}
}

export default connect(mapStateToProps, mapActionsToProps)(Directions)
import * as React from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom'
import { Skeleton } from 'antd'
import { bindActionCreators } from 'redux'

import { fetchDirections } from '~actions/schedules'
import { BusixState } from '~reducers/index'
import { Status, IDirection } from '~reducers/schedules'

interface IDirectionsProps {
  fetchDirections?(lineId)
  directions?: { [lineName : string] : Array<IDirection> }
  match?: {
    params: {
      lineId : string
    }
  }
}

function DirectionsList({ directions, lineId }) {
  return directions.map((direction : IDirection, index : number) => {
    return (
      <li key={`direction_${index}`}>
        <Link to={`/schedules/${lineId}/${direction.name}`}>{direction.start.name} - {direction.target.name}</Link>
      </li>
    )
  })
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

  get directions() : Array<IDirection> | null {
    return this.props.directions[this.lineId]
  }

  render() {
    return (
      <Skeleton active loading={this.directions == null}>
        <ul className="ui-items">
          <DirectionsList directions={this.directions} lineId={this.lineId} />
        </ul>
      </Skeleton>
    )
  }
}

function mapActionsToProps(dispatch) : IDirectionsProps {
  return bindActionCreators({ fetchDirections }, dispatch)
}

function mapStateToProps({ schedules } : BusixState) : IDirectionsProps {
  let { directions } = schedules
  return { directions }
}

export default connect(mapStateToProps, mapActionsToProps)(Directions)

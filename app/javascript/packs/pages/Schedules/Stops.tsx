import * as React from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom'
import { Skeleton } from 'antd'

import { BusixState } from '~reducers/index'
import { Status, IDirection, IStop } from '~reducers/schedules'

interface IDirectionsProps {
  directions?: { [lineName : string] : Array<IDirection> }
  match?: {
    params: {
      lineId : string
      directionName : string
    }
  }
}

function StopsList({ stops, directionName, lineId }) {
  return stops.map((stop : IStop, index : number) => {
    return (
      <li key={`stop_${index}`}>
        <Link to={`/schedules/${lineId}/${directionName}/${stop.name}`}>{stop.name}</Link>
      </li>
    )
  })
}

class Stops extends React.Component<IDirectionsProps> {

  get lineId() : string {
    return this.props.match.params.lineId
  }

  get directionName() : string {
    return this.props.match.params.directionName
  }

  get directions() : Array<IDirection> | null {
    return this.props.directions[this.lineId]
  }

  get stops() : Array<IStop> {
    if (this.directions == null) {
      return []
    }
    let direction = this.directions.find(({ name }) => name == this.directionName)
    if (direction == null) {
      return []
    }

    return direction.stops
  }

  render() {
    return (
      <Skeleton active loading={this.directions == null}>
        <ul className="ui-items">
          <StopsList  stops={this.stops} 
              directionName={this.directionName} 
                     lineId={this.lineId} />
        </ul>
      </Skeleton>
    )
  }
}


function mapStateToProps({ schedules } : BusixState) : IDirectionsProps {
  let { directions } = schedules
  return { directions }
}

export default connect(mapStateToProps)(Stops)

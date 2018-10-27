import * as React from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom'
import { Spin } from 'antd'

import { BusixState } from '~reducers/index'
import { Status, IDirection, IStop } from '~reducers/schedules'

interface IStopsProps {
  directions?: { [lineName : string] : Array<IDirection> }
  currentLine?: string
  currentDirection?: string
  currentStop?: string
}

function StopsList({ stops, currentDirection, currentLine, currentStop }) {
  return stops.map((stop : IStop, index : number) => {
    let klass = currentStop == stop.name ? 'selected' : null
    return (
      <li key={`stop_${index}`}>
        <Link to={`/schedules/${currentLine}/${currentDirection}/${stop.name}`}  className={klass}>
          {stop.name}
          <i className="submenu-arrow" />
        </Link>
      </li>
    )
  })
}

class Stops extends React.Component<IStopsProps> {

  get directions() : Array<IDirection> | null {
    return this.props.directions[this.props.currentLine]
  }

  get stops() : Array<IStop> {
    if (this.directions == null) {
      return []
    }
    let direction = this.directions.find(({ name }) => name == this.props.currentDirection)
    if (direction == null) {
      return []
    }

    return direction.stops
  }

  render() {
    return (
      <Spin spinning={this.directions == null}>
        <ul className="ui-items">
          <StopsList stops={this.stops} {...this.props} />
        </ul>
      </Spin>
    )
  }
}


function mapStateToProps({ schedules } : BusixState) : IStopsProps {
  let { directions } = schedules
  return { directions }
}

export default connect(mapStateToProps)(Stops)

import * as React from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom'
import { Spin, Icon } from 'antd'
import { bindActionCreators } from 'redux'

import { fetchDirections } from '~actions/schedules'
import { BusixState } from '~reducers/index'
import { Status, IDirection } from '~reducers/schedules'

interface IDirectionsProps {
  fetchDirections?(lineId)
  currentLine?: string
  currentDirection?: string
  directions?: { [lineName : string] : Array<IDirection> }
  match?: {
    params: {
      lineId : string
    }
  }
}

function DirectionsList({ directions, lineId, currentDirection }) {
  return (directions || []).map((direction : IDirection, index : number) => {
    let klass = currentDirection == direction.name ? 'selected' : null
    return (
      <li key={`direction_${index}`}>
        <Link to={`/schedules/${lineId}/${direction.name}`} className={klass}>
          {direction.start.name}
          <Icon type="caret-right" theme="outlined" />
          {direction.target.name}
          <i className="submenu-arrow" />
        </Link>
      </li>
    )
  })
}

class Directions extends React.Component<IDirectionsProps> {
  componentDidMount() {
    this.props.fetchDirections(this.props.currentLine)
  }

  componentDidUpdate(prevProps : IDirectionsProps) {
    if (this.props.currentLine != prevProps.currentLine) {
      this.props.fetchDirections(this.props.currentLine)
    }
  }

  get directions() : Array<IDirection> | null {
    return this.props.directions[this.props.currentLine]
  }

  render() {
    return (
      <Spin spinning={this.directions == null}>
        <ul className="ui-items">
          <DirectionsList directions={this.directions} 
                          lineId={this.props.currentLine} 
                          currentDirection={this.props.currentDirection} />
        </ul>
      </Spin>
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

export default connect<{}, {}, IDirectionsProps>(mapStateToProps, mapActionsToProps)(Directions)

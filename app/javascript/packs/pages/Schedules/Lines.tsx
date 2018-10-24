import * as React from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom'
import { Skeleton } from 'antd'
import { bindActionCreators } from 'redux'

import { fetchSchedules } from '~actions/schedules'
import { BusixState } from '~reducers/index'
import { Status, Line } from '~reducers/schedules'

interface ILinesProps {
  fetchSchedules?()
  currentLine?: string
  trams?: Array<Line>
  buses?: Array<Line>
  status? : Status
}

function LinesList({ lines, currentLine }) {
  return lines.map((line : Line, index : number) => {
    let klass = currentLine == line.name ? 'selected' : null
    return (
      <li key={`line_${line.kind}_${index}`} className={klass}>
        <Link to={`/schedules/${line.name}`}>
          {line.name}
          <i className="submenu-arrow" />
        </Link>
      </li>
    )
  })
}

class Lines extends React.Component<ILinesProps> {
  componentDidMount() {
    this.props.fetchSchedules()
  }

  render() {
    return (
      <Skeleton active loading={this.props.status == Status.Loading}>
        <ul className="ui-items">
          <LinesList lines={this.props.buses} lineId={this.props.currentLine} />
          <LinesList lines={this.props.trams} lineId={this.props.currentLine} />
        </ul>
      </Skeleton>
    )
  }
}

function mapActionsToProps(dispatch) : ILinesProps {
  return bindActionCreators({ fetchSchedules }, dispatch)
}

function mapStateToProps({ schedules } : BusixState) : ILinesProps {
  let { status, trams, buses } = schedules
  return { status, trams, buses }
}

export default connect(mapStateToProps, mapActionsToProps)(Lines)
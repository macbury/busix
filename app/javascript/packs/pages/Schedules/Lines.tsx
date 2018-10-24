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
  trams?: Array<Line>
  buses?: Array<Line>
  status? : Status
}

function LinesList({ lines }) {
  return lines.map((line : Line, index : number) => {
    return (
      <li key={`line_${line.kind}_${index}`}>
        <Link to={`/schedules/${line.name}`}>{line.name}</Link>
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
          <LinesList lines={this.props.buses} />
          <LinesList lines={this.props.trams} />
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
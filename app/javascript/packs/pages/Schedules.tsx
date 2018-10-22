import * as React from 'react'
import Application from '../containers/application'
import { Skeleton } from 'antd'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { fetchSchedules } from '~actions/schedules'

import { BusixState } from '~reducers/index'
import { Status, Line } from '~reducers/schedules'

interface ISchedulesProps {
  fetchSchedules?()
  status? : Status
  trams?: Array<Line>
  buses?: Array<Line>
}

function LinesList({ lines }) {
  return lines.map((line : Line, index : number) => {
    return <p key={`line_${line.kind}_${index}`}>{line.name}</p>
  })
}

class Schedules extends React.Component<ISchedulesProps> {
  componentDidMount() {
    this.props.fetchSchedules()
  }

  render() {
    return (
      <Application>
        <Skeleton active loading={this.props.status == Status.Loading}>
          <h4>Buses</h4>
          <LinesList lines={this.props.buses} />
          <h4>Trams</h4>
          <LinesList lines={this.props.trams} />
        </Skeleton>
      </Application>
    )
  }
}

function mapActionsToProps(dispatch) : ISchedulesProps {
  return bindActionCreators({ fetchSchedules }, dispatch)
}

function mapStateToProps({ schedules } : BusixState) : ISchedulesProps {
  let { status, trams, buses } = schedules
  return { status, trams, buses }
}

export default connect(mapStateToProps, mapActionsToProps)(Schedules)

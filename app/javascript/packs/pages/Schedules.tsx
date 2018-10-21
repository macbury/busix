import * as React from 'react'
import Application from '../containers/application'
import { Skeleton } from 'antd'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { fetchSchedules } from '~actions/schedules'

import { BusixState } from '~reducers/index'
import { Status } from '~reducers/schedules'

interface ISchedulesProps {
  fetchSchedules?()
  status? : Status
}

class Schedules extends React.Component<ISchedulesProps> {
  componentDidMount() {
    this.props.fetchSchedules()
  }

  render() {
    return (
      <Application>
        <Skeleton active loading={this.props.status == Status.Loading}>
          <p>Lines are loaded!</p>
        </Skeleton>
      </Application>
    )
  }
}

function mapActionsToProps(dispatch) : ISchedulesProps {
  return bindActionCreators({ fetchSchedules }, dispatch)
}

function mapStateToProps({ schedules } : BusixState) : ISchedulesProps {
  let { status } = schedules
  return { status }
}

export default connect(mapStateToProps, mapActionsToProps)(Schedules)
import * as React from 'react'
import Application from '../containers/application'
import { Skeleton } from 'antd'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { fetchSchedules } from '~actions/schedules'

interface ISchedulesProps {
  fetchSchedules();
}

class Schedules extends React.Component<ISchedulesProps> {
  componentDidMount() {
    this.props.fetchSchedules()
  }

  render() {
    return (
      <Application>
        <Skeleton active loading />
      </Application>
    )
  }
}

function mapActionsToProps(dispatch) : ISchedulesProps {
  return bindActionCreators({ fetchSchedules }, dispatch)
}

export default connect(null, mapActionsToProps)(Schedules)
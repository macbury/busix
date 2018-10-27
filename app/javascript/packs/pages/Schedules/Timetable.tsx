import * as React from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom'
import { Spin } from 'antd'

import { BusixState } from '~reducers/index'
import {} from '~reducers/schedules'

interface ITimetableProps {
  currentLine?: string
  currentDirection?: string
  currentStop?: string,
  forDate?: string
}

class Timetable extends React.Component<ITimetableProps> {
  render() {
    return (
      <Spin spinning={true}>
        TimeTable£££££
      </Spin>
    )
  }
}


function mapStateToProps({ schedules } : BusixState) : ITimetableProps {
  return {}
}

export default connect(mapStateToProps)(Timetable)

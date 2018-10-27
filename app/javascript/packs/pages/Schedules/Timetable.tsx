import * as React from 'react'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { Link } from 'react-router-dom'
import { Spin } from 'antd'

import { BusixState } from '~reducers/index'
import { fetchTimetable } from '~actions/schedules'
import { } from '~reducers/schedules'

interface ITimetableProps {
  fetchTimetable?,
  currentLine?: string
  currentDirection?: string
  currentStop?: string,
  forDate?: string
}

class Timetable extends React.Component<ITimetableProps> {
  componentDidMount() {
    this.props.fetchTimetable({
      "from": "Jarzębiny",
      "to": "Nowy Bieżanów P+R",
      "line": "73",
      "at": "now"
    })
  }

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

function mapActionsToProps(dispatch) : ITimetableProps {
  return bindActionCreators({ fetchTimetable }, dispatch)
}

export default connect(mapStateToProps, mapActionsToProps)(Timetable)

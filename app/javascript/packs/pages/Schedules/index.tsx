import * as React from 'react'
import { Route } from 'react-router-dom'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { Row, Col, Input } from 'antd'

import ScrollCol from './ScrollCol'
import Application from '../../containers/application'
import { BusixState } from '~reducers/index'
import { setBreadcrump, setCurrentPage } from '~actions/ui'
import ShowIf from '~components/helpers/ShowIf'

import Lines from './Lines'
import Directions from './Directions'
import Stops from './Stops'
import Timetable from './Timetable'

interface ISchedulesProps {
  setBreadcrump?(crumbs),
  setCurrentPage?(page),
  match?: {
    params: {
      currentLine: string
      currentDirection: string
      currentStop: string
      forDate: string
    }
  }
}

class Schedules extends React.Component<ISchedulesProps> {

  private updateBreadcrump() {
    let { currentLine, currentDirection, currentStop } = this.props.match.params

    let crumps = [
      { name: I18n.t('schedules.title'), path: '/schedules' }
    ]

    if (!!currentLine) {
      crumps.push({ name: currentLine, path: `/schedules/${currentLine}` })
    }
    
    if (!!currentDirection) {
      crumps.push({ name: currentDirection, path: `/schedules/${currentLine}/${currentDirection}` })
    }

    if (!!currentStop) {
      crumps.push({ name: currentStop, path: `/schedules/${currentLine}/${currentDirection}/${currentStop}` })
    }

    this.props.setBreadcrump(crumps)
  }
  componentDidMount() {
    this.updateBreadcrump()
    this.props.setCurrentPage('schedules')
  }

  componentDidUpdate(prevProps : ISchedulesProps) {
    this.updateBreadcrump()
  }

  render() {
    let { currentLine, currentDirection, currentStop } = this.props.match.params
    let params = { currentLine, currentDirection, currentStop }
    return (
      <Application>
        <Row className="full-height-row">
          <ScrollCol span={2}>
            <Lines {...params} />
          </ScrollCol>
          <ScrollCol span={7}>
            <ShowIf condition={currentLine}>
              <Directions {...params} />
            </ShowIf>
          </ScrollCol>
          <ScrollCol span={5}>
            <ShowIf condition={currentDirection}>
              <Stops {...params} />
            </ShowIf>
          </ScrollCol>
          <ScrollCol span={10}>
            <ShowIf condition={currentStop}>
              <Timetable {...params} />
            </ShowIf>
          </ScrollCol>
        </Row>
      </Application>
    )
  }
}

function mapActionsToProps(dispatch) : ISchedulesProps {
  return bindActionCreators({ setBreadcrump, setCurrentPage }, dispatch)
}

function mapStateToProps(state : BusixState) : ISchedulesProps {
  return {}
}

export default connect(mapStateToProps, mapActionsToProps)(Schedules)

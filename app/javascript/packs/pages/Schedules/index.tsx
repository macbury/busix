import * as React from 'react'
import { Route } from 'react-router-dom'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { Row } from 'antd'

import ScrollCol from './ScrollCol'
import Application from '../../containers/application'
import { BusixState } from '~reducers/index'
import { setBreadcrump } from '~actions/ui'

import Lines from './Lines'
import Directions from './Directions'
import Stops from './Stops'

interface ISchedulesProps {
  setBreadcrump?(crumbs)
}

class Schedules extends React.Component<ISchedulesProps> {
  componentDidMount() {
    this.props.setBreadcrump([
      { name: 'Schedules', path: '/schedules' }
    ])
  }

  render() {
    return (
      <Application>
        <Row className="full-height-row">
          <ScrollCol span={2}>
            <Route path="/schedules" component={Lines} />
          </ScrollCol>

          <ScrollCol span={5}>
            <Route path="/schedules/:lineId" component={Directions} />
          </ScrollCol>
          <ScrollCol span={5}>
            <Route path="/schedules/:lineId/:directionName" component={Stops} />
          </ScrollCol>
          <ScrollCol span={12}>
            <p>Timetable</p>
          </ScrollCol>
        </Row>
      </Application>
    )
  }
}

function mapActionsToProps(dispatch) : ISchedulesProps {
  return bindActionCreators({ setBreadcrump }, dispatch)
}

function mapStateToProps(state : BusixState) : ISchedulesProps {
  return {}
}

export default connect(mapStateToProps, mapActionsToProps)(Schedules)

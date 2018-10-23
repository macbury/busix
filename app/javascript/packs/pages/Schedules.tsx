import * as React from 'react'
import Application from '../containers/application'
import { Skeleton, Row, Col } from 'antd'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { fetchSchedules } from '~actions/schedules'

import { BusixState } from '~reducers/index'
import { Status, Line } from '~reducers/schedules'
import { setBreadcrump } from '~actions/ui'

interface ISchedulesProps {
  fetchSchedules?()
  setBreadcrump?(crumbs)
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
    this.props.setBreadcrump([
      { name: 'Schedules', path: '/schedules' }
    ])
  }

  render() {
    return (
      <Application>
        <Row>
          <Col span={4}>
            <Skeleton active loading={this.props.status == Status.Loading}>
              <h4>Buses</h4>
              <LinesList lines={this.props.buses} />
              <h4>Trams</h4>
              <LinesList lines={this.props.trams} />
            </Skeleton>
          </Col>
          <Col span={4}>
            <p>directions</p>
          </Col>
          <Col span={4}>
            <p>Stops</p>
          </Col>
          <Col span={4}>
            <p>Departures</p>
          </Col>
          <Col span={8}>
            <p>Map</p>
          </Col>
        </Row>
        
      </Application>
    )
  }
}

function mapActionsToProps(dispatch) : ISchedulesProps {
  return bindActionCreators({ fetchSchedules, setBreadcrump }, dispatch)
}

function mapStateToProps({ schedules } : BusixState) : ISchedulesProps {
  let { status, trams, buses } = schedules
  return { status, trams, buses }
}

export default connect(mapStateToProps, mapActionsToProps)(Schedules)

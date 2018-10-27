import * as React from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom'
import { Spin } from 'antd'
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
      <li key={`line_${line.kind}_${index}`}>
        <Link to={`/schedules/${line.name}`} className={klass}>
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
    let { currentLine } = this.props
    return (
      <Spin spinning={this.props.status == Status.Loading}>
        <ul className="ui-items">
          <li className="ui-items-header">{I18n.t('schedules.trams')}</li>
          <LinesList lines={this.props.trams} currentLine={currentLine} />
          <li className="ui-items-header">{I18n.t('schedules.buses')}</li>
          <LinesList lines={this.props.buses} currentLine={currentLine} />
        </ul>
      </Spin>
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

export default connect<{}, {}, ILinesProps>(mapStateToProps, mapActionsToProps)(Lines) 

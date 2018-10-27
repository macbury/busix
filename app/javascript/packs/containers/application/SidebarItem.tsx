import * as React from 'react'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { push } from 'connected-react-router'
import { Icon } from 'antd'

import { BusixState } from '~reducers/index'

interface ISidebarItem {
  push?(path)
  page? : string
  path? : string
  icon? : string
  currentPage? : string
}

class SidebarItem extends React.Component<ISidebarItem> {
  private onSelect() {
    this.props.push(this.props.path)
  }

  get klassName() {
    return this.props.currentPage == this.props.page ? 'ant-menu-item ant-menu-item-selected' : 'ant-menu-item'
  }

  render() {
    return (
      <li className={this.klassName} style={ { paddingLeft: '24px' } } onClick={this.onSelect.bind(this)}>
        <Icon type={this.props.icon} theme="outlined" />
        <span>{I18n.t('layout.header.' + this.props.page)}</span>
      </li>
    )
  }
}

function mapActionsToProps(dispatch) : ISidebarItem {
  return bindActionCreators({ push }, dispatch)
}

function mapStateToProps({ ui } : BusixState) : ISidebarItem {
  let { currentPage } = ui
  return { currentPage }
}

export default connect<{}, {}, ISidebarItem>(mapStateToProps, mapActionsToProps)(SidebarItem)

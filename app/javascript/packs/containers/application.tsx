import * as React from 'react'
import { push } from 'connected-react-router'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { BusixState } from '../reducers'

import { toggleSidebar } from '~actions/ui'
import { IBreadcrumpItem } from '~reducers/ui'

import { Layout, Menu, Breadcrumb, Icon } from 'antd'

const { Header, Content, Footer, Sider } = Layout
const SubMenu = Menu.SubMenu

interface ApplicationProps {
  path : string
  collapse: boolean
  breadcrumbs: Array<IBreadcrumpItem>
  push?(action)
  toggleSidebar?()
}

function Breadcrumbs({ breadcrumbs }) {
  if (breadcrumbs == null || breadcrumbs.length == 0) {
    return null
  }

  let items = breadcrumbs.map((item : IBreadcrumpItem, index) => {
    return <Breadcrumb.Item>{item.name}</Breadcrumb.Item>
  })

  return (
    <Breadcrumb>
      {items}
    </Breadcrumb>
  )
}

class Application extends React.Component<ApplicationProps, any> {
  private onNavClick({item, key}) {
    this.props.push(key)
  }

  render() {
    return (
      <Layout className="main-layout">
        <Sider collapsible collapsed={this.props.collapse} onCollapse={this.props.toggleSidebar}>
          <div className="logo" />
          <Menu theme="dark" defaultSelectedKeys={['1']} mode="inline" selectedKeys={[this.props.path]}>
            <Menu.Item key="/" onClick={this.onNavClick.bind(this)}>
              <Icon type="environment" theme="outlined" />
              <span>{I18n.t('layout.header.find_path')}</span>
            </Menu.Item>
            <Menu.Item key="/schedules" onClick={this.onNavClick.bind(this)}>
              <Icon type="branches" theme="outlined" />
              <span>{I18n.t('layout.header.schedules')}</span>
            </Menu.Item>
            <Menu.Item key="/api/explorer" onClick={this.onNavClick.bind(this)}>
              <Icon type="experiment" theme="outlined" />
              <span>{I18n.t('layout.header.api')}</span>
            </Menu.Item>
          </Menu>
        </Sider>
        <Layout>
          <Content>
            <Breadcrumbs breadcrumbs={this.props.breadcrumbs} />
            {this.props.children}
          </Content>
        </Layout>
      </Layout>
    )
  }
}

function mapStateToProps({ router, ui } : BusixState) : ApplicationProps {
  let { collapse, breadcrumbs } = ui
  return {
    path: router.location.pathname,
    collapse,
    breadcrumbs
  }
}

function mapActions(dispatch) {
  return bindActionCreators({ push, toggleSidebar }, dispatch)
}

export default connect(mapStateToProps, mapActions)(Application)

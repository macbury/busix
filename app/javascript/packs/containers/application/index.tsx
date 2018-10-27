import * as React from 'react'
import { push } from 'connected-react-router'
import { Link } from 'react-router-dom'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { BusixState } from '~reducers/index'

import { toggleSidebar } from '~actions/ui'
import { IBreadcrumpItem } from '~reducers/ui'

import { Layout, Menu, Breadcrumb, Icon } from 'antd'

import SidebarItem from './SidebarItem'

const { Header, Content, Footer, Sider } = Layout
const SubMenu = Menu.SubMenu

interface ApplicationProps {
  path : string
  currentPage : string
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
    return (
      <Breadcrumb.Item key={`bread_${index}`}>
        <Link to={item.path}>
          {item.name}
        </Link>
      </Breadcrumb.Item>
    )
  })

  return (
    <Breadcrumb>
      {items}
    </Breadcrumb>
  )
}

class Application extends React.Component<ApplicationProps, any> {
  private onNavClick({item, key}, path) {
    this.props.push(path)
  }

  render() {
    return (
      <Layout className="main-layout">
        <Sider collapsible collapsed={this.props.collapse} onCollapse={this.props.toggleSidebar}>
          <div className="logo" />
          <Menu theme="dark" defaultSelectedKeys={[this.props.currentPage]} mode="inline">
            <SidebarItem page="find_path" 
                         path="/" 
                         icon="environment" />
            <SidebarItem page="schedules" 
                         path="/schedules" 
                         icon="branches"  />
            <SidebarItem page="api_explorer" 
                         path="/api/explorer" 
                         icon="experiment"  />
          </Menu>
        </Sider>
        <Layout>
          <Content className="main-content">
            <Breadcrumbs breadcrumbs={this.props.breadcrumbs} />
            {this.props.children}
          </Content>
        </Layout>
      </Layout>
    )
  }
}

function mapStateToProps({ router, ui } : BusixState) : ApplicationProps {
  let { collapse, breadcrumbs, currentPage } = ui
  return {
    path: router.location.pathname,
    collapse,
    breadcrumbs,
    currentPage
  }
}

function mapActions(dispatch) {
  return bindActionCreators({ push, toggleSidebar }, dispatch)
}

export default connect(mapStateToProps, mapActions)(Application)

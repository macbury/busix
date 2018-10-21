import * as React from 'react'
import { Layout, Menu } from 'antd'
import { push } from 'connected-react-router'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { BusixState } from '../reducers'
const { Header, Content } = Layout

interface ApplicationProps {
  path : string,
  push?(action)
}

class Application extends React.Component<ApplicationProps, any> {
  private onNavClick({item, key}) {
    this.props.push(key)
  }

  render() {
    return (
      <Layout>
        <Header>
          <Menu theme="dark" 
                mode="horizontal" 
                style={{ lineHeight: '64px' }} 
                selectedKeys={[this.props.path]}
                onClick={this.onNavClick.bind(this)}>
            <Menu.Item key="/">{I18n.t('layout.header.find_path')}</Menu.Item>
            <Menu.Item key="/schedules">{I18n.t('layout.header.schedules')}</Menu.Item>
            <Menu.Item key="/api/explorer">{I18n.t('layout.header.api')}</Menu.Item>
          </Menu>
        </Header>
        <Content>
          { this.props.children }
        </Content>
      </Layout>
    )
  }
}

function mapStateToProps({ router } : BusixState) : ApplicationProps {
  return {
    path: router.location.pathname
  }
}

function mapActions(dispatch) {
  return bindActionCreators({ push }, dispatch)
}

export default connect(mapStateToProps, mapActions)(Application)
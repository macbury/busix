import * as React from 'react'
import { Navbar, NavbarBrand } from 'reactstrap'

export default class Application extends React.Component {
  render() {
    return (
      <div>
        <Navbar color="light" light>
          <NavbarBrand href="/">Busix</NavbarBrand>
        </Navbar>

        { this.props.children }
      </div>
    )
  }
}
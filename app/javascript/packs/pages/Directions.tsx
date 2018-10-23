import * as React from 'react'
import { clearBreadcrump } from '~actions/ui'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import Application from '../containers/application'
import { Map, TileLayer, Marker, Popup } from 'react-leaflet'

interface IApiExplorerProps {
  clearBreadcrump?()
}

class Directions extends React.Component<IApiExplorerProps> {
  componentDidMount() {
    this.props.clearBreadcrump()
  }

  render() {
    const position = [51.505, -0.09]
    return (
      <Application>
        <Map zoom={13}>
          <TileLayer
            attribution="&amp;copy <a href=&quot;http://osm.org/copyright&quot;>OpenStreetMap</a> contributors"
            url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
          />
        </Map>
      </Application>
    )
  }
}

function mapActionsToProps(dispatch) {
  return bindActionCreators({ clearBreadcrump }, dispatch)
}

export default connect(null, mapActionsToProps)(Directions)

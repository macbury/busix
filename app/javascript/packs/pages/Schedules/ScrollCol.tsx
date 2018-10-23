import React from 'react'
import { Col } from 'antd'

export default function ScrollCol({ span, children }) {
  return (
    <Col span={span} className="col-scroll">
      {children}
    </Col>
  )
}
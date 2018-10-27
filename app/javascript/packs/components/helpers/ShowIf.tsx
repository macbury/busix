import * as React from 'react'

interface IShowIf {
  condition : string
  children : any
}

export default function ShowIf({ condition, children } : IShowIf) {
  if (!condition) {
    return null
  }

  return <React.Fragment>{ children }</React.Fragment>
}

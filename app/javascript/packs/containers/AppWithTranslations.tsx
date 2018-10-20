import * as React from 'react'
require("expose-loader?I18n!i18n-js")

interface IState {
  loading : boolean;
}

export default class AppWithTranslations extends React.Component<any, IState> {
  constructor(prop) {
    super(prop)
    this.state = { loading: true }
  }

  private async loadTranslations(value : Response) {
    let content = await value.json()

    I18n.reset()
    I18n.translations = content[0].translations
    I18n.locale = 'pl'
    this.setState({ loading: false })
    this.forceUpdate()
  }

  componentDidMount() {
    fetch('/api/locales').then(this.loadTranslations.bind(this))
  }

  render() {
    if (this.state.loading) {
      return <p>Loading</p>
    } else {
      return <React.Fragment>{this.props.children}</React.Fragment>
    }
  }
}
import * as m from 'mithril'
import { View } from 'dilithium'
import Api from 'services/api'
import Header from 'components/header'

export default class PagesHome extends View
  location_name: 'pages_home'
  events:
    'pages/home': 'success'
  reindex:=>
    #Api.pages.home()
  render:=>
    m 'main',
      m Header
      m 'article'


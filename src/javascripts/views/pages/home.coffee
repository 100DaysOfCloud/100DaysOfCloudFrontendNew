import * as m from 'mithril'
import { View } from 'dilithium'
import Api from 'services/api'
import Auth from 'services/auth'
import Header from 'components/header'

export default class PagesHome extends View
  location_name: 'pages_home'
  events:
    'pages/home': 'success'
  reindex:=>
    Auth.current_user (user)=>
      console.log 'user', user
      @user = user
      m.redraw(true)
  render:=>
    m 'main',
      m Header, user: @user
      m 'article',
        'home'


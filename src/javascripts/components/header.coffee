import * as m from 'mithril'
import { Component } from 'dilithium'
import Auth from 'services/auth'

export default class Header extends Component
  expects:
    user:
      allow_nil: true
  logout:=>
    Auth.logout()
  render:=>
    m 'header',
      m '.logo'
      m m.route.Link, href: '/', 'Home'
      m m.route.Link, href: '/journeyers', 'Journeyers'
      m m.route.Link, href: '/intake', 'User Intake'
      m m.route.Link, href: '/account', 'Account Settings'
      if @user && @user.username
        m '.logout', onclick: @logout, 'Logout'
      else
        [
          m 'a', href: Auth.signup_url(), 'Signup'
          m 'a', href: Auth.login_url(), 'Login'
        ]

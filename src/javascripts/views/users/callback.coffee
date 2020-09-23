import * as m from 'mithril'
import { View } from 'dilithium'
import Auth from 'services/auth'

export default class UsersCallback extends View
  oninit:(vnode)=>
    super(vnode)
    @token = m.route.param('token')
    console.log 'code'
    #Auth.authorize(@token)
  render:=>
    m 'div',
      m 'span', 'token:'
      m 'span', @token

import * as m from 'mithril'
import { View } from 'dilithium'
import Auth from 'services/auth'

export default class UsersCallback extends View
  oninit:(vnode)=>
    super(vnode)
    @code = m.route.param('code')
    console.log 'code' 
    Auth.authorize(@code)
  render:=>
    m 'div', @code

import Amplify from '@aws-amplify/core'
import { Auth } from '@aws-amplify/auth'
import * as m from 'mithril'
import config from 'config'

# https://aws.amazon.com/blogs/mobile/understanding-amazon-cognito-user-pool-oauth-2-0-grants/
# https://docs.aws.amazon.com/cognito/latest/developerguide/authorization-endpoint.html
class MyAuth
  constructor:->
    @configure()
  configure:=>
    Amplify.configure
      userPoolId: config.cognito_user_pool_id
      userPoolWebClientId: config.cognito_client_app_id
      cookieStorage:
        domain: config.cognito_cookie_domain
        path: '/'
        expires: 7
        secure: false
    Auth.configure
      oauth:
        domain: config.cognito_ipd
        scope: ["email", "openid","profile"]
        # we need the /autologin step in between to set the cookies properly,
        # we don't need that when signing out though
        redirectSignIn: config.cognito_redirect_sign_in
        redirectSignOut: config.cognito_redirect_sign_out
        responseType: "token"
  domain:=>
    "https://100daysofcloud.auth.us-east-1.amazoncognito.com"
  logout:=>
    user = Auth.signOut()
    user.then(@logout_success)
  logout_success:=>
    window.location.href = '/'
  current_user:(success,error)=>
    user = Auth.currentUserInfo()
    user.then(success).catch(error)
  current_session:(success,error)=>
    user = Auth.currentSession()
    user.then(success).catch(error)
  url:(kind)=>
    url  = @domain()
    url += "/#{kind}"
    url += "?client_id=#{config.cognito_client_app_id}"
    url += "&response_type=token"
    url += "&scope=#{config.cognito_scope}"
    url += "&redirect_uri=#{config.cognito_redirect_uri}"
  login_url:=>
    @url('login')
  signup_url:=>
    @url('signup')
  authorize:(code)=>
    url = "#{@domain()}/oauth2/authorize"
    url += "?response_type=token"
    url += "&client_id=#{config.cognito_client_app_id}"
    url += "&redirect_uri=http://localhost:8080/"
    url += "&identity_provider=COGNITO"
    url += "&scope=#{config.cognito_scope}"
    url += "&code_challenge=#{code}"
    console.log 'autorize', url
    resp = m.request
      method: "GET"
      url: url
    resp.then(@authorize_success).catch(@authorize_error)
  authorize_success:(result)=>
    console.log 'authorize_success', result
  authorize_error:(err)=>
    console.log 'authorize_error', err
auth = new MyAuth()
export default auth

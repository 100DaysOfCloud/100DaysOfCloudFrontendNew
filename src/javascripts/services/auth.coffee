import Amplify from '@aws-amplify/core'
import { Auth } from '@aws-amplify/auth'
import * as m from 'mithril'
import config from 'config'

# https://aws.amazon.com/blogs/mobile/understanding-amazon-cognito-user-pool-oauth-2-0-grants/
# https://docs.aws.amazon.com/cognito/latest/developerguide/authorization-endpoint.html

class MyAuth
  constructor:->
    Amplify.configure
      userPoolId: config.cognito_user_pool_id
      userPoolWebClientId: config.cognito_client_app_id
  domain:=>
    "https://100daysofcloud.auth.us-east-1.amazoncognito.com"
  current_session:=>
    user = Auth.currentSession()
    user.then(@current_session_success).catch(@current_session_error)
  current_session_success:=>
    console.log 'args', arguments
  current_session_error:(err_msg)=>
    console.log err_msg
  url:(kind)=>
    url  = @domain()
    url += "/#{kind}"
    url += "?client_id=#{config.cognito_client_app_id}"
    url += "&response_type=code"
    url += "&scope=#{config.cognito_scope}"
    url += "&redirect_uri=#{config.cognito_redirect_uri}"
  login_url:=>
    @url('login')
  signup_url:=>
    @url('signup')
  authorize:(code)=>
    url = "#{@domain()}/oauth2/authorize"
    url += "?response_type=code"
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
    console.log('authorize_success',result)
  authorize_error:(err)=>
    console.log 'authorize_error', err
auth = new MyAuth()
export default auth

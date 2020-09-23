import * as m from 'mithril'
import { View } from 'dilithium'
import Api from 'services/api'
import Header from 'components/header'
import InputText from 'components/fields/input_text'
import UserAccount from 'models/user_account'

export default class UsersAccount extends View
  location_name: 'users_account'
  events:
    'users/account': 'success'
  constructor:(args)->
    super(args)
    @model = new UserAccount()
  reindex:=>
    #Api.users.account()
  submit:(ev)=>
    ev.preventDefault()
    attrs =
      user: @model.params()
    #Api.users.intake_update()
    return false
  render:=>
    m 'main',
      m Header
      m 'article',
        m 'form', onsubmit: @submit,
          m InputText,
            attribute: @model.twitter_handle
            handle: 'twitter_handle'
            label: 'Twitter Handle'
          m InputText,
            attribute: @model.github_username
            handle: 'github_username'
            label: 'Github Username'
          m InputText,
            attribute: @model.linkedin_url
            handle: 'linkedin_url'
            label: 'LinkedIn URL'
          m InputText,
            attribute: @model.github_journey_url
            handle: 'github_journey_url'
            label: 'Github URL (100DaysOfCloud Journey Template)'
          m InputText,
            attribute: @model.personal_blog_url
            handle: 'personal_blog_url'
            label: 'Personal Blog URL'

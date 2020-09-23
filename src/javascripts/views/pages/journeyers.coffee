import * as m from 'mithril'
import { View } from 'dilithium'
import Api from 'services/api'
import Header from 'components/header'
import Journeyer from 'components/journeyer'

export default class PagesJourneyers extends View
  location_name: 'pages_journeyers'
  events:
    'pages/journeyers': 'success'
  reindex:=>
    Api.pages.journeyers()
  render:=>
    return unless @model
    m 'main',
      m Header
      m 'article',
        for journeyer in @model.journeyers
          m Journeyer, model: journeyer

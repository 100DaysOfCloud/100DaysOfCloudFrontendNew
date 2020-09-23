import * as m from 'mithril'
import { Component } from 'dilithium'

export default class Journeyer extends Component
  expects:
    model: true
  render:=>
    m '.journeyer',
      m '.name', @model.name

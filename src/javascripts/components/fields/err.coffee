import * as m from 'mithril'
import { Component } from 'dilithium'

export default class ErrorMsg extends Component
  expects:
    errors: true
    title: true
    overrides:
      allow_nil: true
  render:=>
    if @errors().length > 0
      m '.err_msg.err',
        for err in @errors()
          if @overrides && @overrides[err]
            m '.err', @overrides[err]
          else
            m '.err', "#{@title} #{err}"
    else
      m '.err_msg'

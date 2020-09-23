import * as m from 'mithril'
import { Component } from 'dilithium'

export default class FileField extends Component
  expects:
    attribute: true
    handle: true
    label:
      allow_nil: true
  _onchange:(ev)=>
    files = ev.target.files
    files = files[0] if files.length is 1
    @attribute.value files
  attrs:=>
    attrs =
      onchange: @_onchange
    attrs
  classes:=>
    if @attribute.errors().length > 0
      'err'
    else
      ''
  render:=>
    m ".field.text_field.#{@handle}", class: @classes(),
      if @label
        m 'label', @label
      m "input[type='file']", @attrs()

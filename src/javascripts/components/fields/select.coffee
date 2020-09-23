import * as m from 'mithril'
import { Component } from 'dilithium'

export default class Select extends Component
  expects:
    attribute: true
    options: true
    handle: true
    label:
      allow_nil: true
    onchange:
      allow_nil: true
    include_blank:
      allow_nil: true
  ev_onchange:(ev)=>
    @attribute.value ev.target.value
    if @onchange
      @onchange(ev.target.value)
  attrs:=>
    attrs =
      onchange: @ev_onchange
      value: @attribute.value()
    attrs
  option:(option)=>
    m 'option', value: option.id, option.name
  view:(vnode)=>
    m ".field.select.#{@handle}",
      if @label
        m 'label', @label
      m "select", @attrs(),
        if @include_blank
          m 'option'
        for option in @options
          @option(option)

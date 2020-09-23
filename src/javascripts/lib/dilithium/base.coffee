import { v4 as uuid } from 'uuid'
import { $register, $deregister } from './events'
import { Util } from './util'

RenderUndefined = (message,component,scope)->
   this.message   = message
   this.component = component
   this.scope     = scope

ExpectedComponentAttributes = (message,attribute,component,scope)->
   this.message   = message
   this.attribute = attribute
   this.component = component
   this.scope     = scope

export default class Base
  # unique way of indentifying each components
  scope:->
    uuid()
  # register events and bind to instance methods
  # eg. @$on 'users/index', @success
  $on: (name,fun,opts={})=>
    $register @_scope, name, fun
  $off:(name)=>
    $deregister @_scope, name
  oninit:(vnode)=>
    return unless vnode
    @_scope = @scope()
    for name,func of @events
      @$on name, @[func]
    @_map_attributes(vnode.attrs)
    return true
  onremove:(vnode)=>
    # remove events
    for name,func of @events
      @$off name, @[func]
    return true
  view:(vnode)->
    @render()
  render:=>
    component =  @constructor.name
    throw new RenderUndefined 'expected render function to be defined', component, @_scope
  onbeforeupdate:(vnode)->
    return unless vnode
    @_map_attributes(vnode.attrs)
    return true

  # Internal functions
  # ------------------
  # Theses are are preceeded by an _
  # to indicate they are internal functions
  # and should generally not be called manually

  # automatically map attributes
  # If expects is present only strictly
  # map attributes defined in expects
  # and validate the expects requirements
  _map_attributes:(attrs)=>
    if @expects
      for k,v of @expects
        @[k] = @_check_expected_attribute(k,attrs[k])
    else
      for k,v of attrs
        @[k] = v
  # A componenets expects specific attributes
  # in order to work. These are defined as such:
  #
  #```
  #class Materials extends Component
  #  expects:
  #    user: ['id']
  #    material: true
  #    material: 'func'
  #    tasks:
  #      array: true
  #    project:
  #      allow_nil: true
  #    task: Task
  #```
  #
  #If it does not meet expectations throw
  #an error
  _check_expected_attribute:(attribute,value)=>
    return unless @expects
    check     = @expects[attribute]
    return value if check.allow_nil
    component =  @constructor.name
    if typeof(check) is 'boolean' and !value?
      throw new ExpectedComponentAttributes 'expected attribute to be present', attribute, component, @_scope
    else if check.array and !Util.is_array(value)
      throw new ExpectedComponentAttributes 'expected attribute to be an array', attribute, component, @_scope
    value

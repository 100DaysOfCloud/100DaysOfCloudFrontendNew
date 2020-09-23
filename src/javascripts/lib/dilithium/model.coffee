import stream from 'mithril/stream'

export class Model
  constructor:(attrs={})->
    @id = stream(attrs.id || null)
    for k,v of @attributes
      if v is 'ArrayModelAttribute'
        @[k] = new ArrayModelAttribute()
      else if v is 'ArrayAttribute'
        @[k] = new ArrayAttribute()
      else
        @[k] = new Attribute()

  errors:(attributes={})=>
    for k,v of attributes
      @[k].errors(v)

  # exclude - allows you to exclude params
  # eg. exclude: ['exams']
  #
  # rename - allows you to change the name of the param
  # eg. rename: {exams: 'exam_ids' }
  params:(opts={})=>
    attrs = {}
    attrs.id = @id()
    for k,v of @attributes
      # if the exclude key exists ignore it.
      if !!opts.exclude is false || (opts.exclude && opts.exclude.indexOf(k) is -1)
        # rename key
        key =
        if opts.rename
          opts.rename[k] || k
        else
          k

        if v is 'ArrayModelAttribute'
          attrs[key] = @[k].values()
        else if v is 'ArrayAttribute'
          attrs[key] = @[k].values()
        else
          attrs[key] = @[k].value()
    attrs
  reset:(attrs={})=>
    @id(attrs.id || null)
    for k,v of @attributes
      if attrs[k]
        @[k].value(attrs[k])
      else
        @[k].value('')

export class Attribute
  constructor:->
    @value = stream(null)
    @errors = stream([])

# Represent an array of attributes
# eg. a list of checkboxes
export class ArrayAttribute
  constructor:->
    @array = []
    @value = stream(null)
  at:(v)=>
    @array[v]
  reset:(size)=>
    @array = []
    for v in [0..size-1]
      @array.push new Attribute()
  values:=>
    values = []
    for a in @array
      if a.value()
        values.push a.value()
    values

# Represent an array of models
# eg. a list of checkboxes
export class ArrayModelAttribute
  constructor:->
    @array = []
    @value = stream(null)
  at:(v)=>
    @array[v]
  reset:(size,model)=>
    @array = []
    for v in [0..size-1]
      @array.push new model()
  values:(opts)=>
    values = []
    for a in @array
      values.push a.params(opts)
    values

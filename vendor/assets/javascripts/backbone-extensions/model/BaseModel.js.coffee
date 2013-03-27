#This file contains AAA In the beginning because it forces this file to be loaded first

class S98.Models.BaseModel extends Backbone.Model

  getExternalModel: (collection, id) ->
    alert "getExternalModel from BaseModel is commented because it needs to be refactored"
    #S98.Models.loadModelFromCollection collection, id

  getCollection: (collection) ->
    alert "getCollection from BaseModel is commented because it needs to be refactored"
    #S98.Models.getCollection collection

  #Overriden get to work with nested models
  get: (attribute) ->
    return super attribute if typeof(attribute) != 'string'
    attributes = attribute.split('.')
    return super attribute if attributes.length == 1
    model = super(attributes[0])
    model.get(attributes[1..].toString())

  sync: (method,object,options) ->
    console.log 'Just called sync'
    options?.error = @handle_error
    super

  toJSON: ->
    if @_isSerializing?
      @id || @cid

    @_isSerializing = true
    json = _.clone(@attributes)
    _.each(json, (value,name) ->
      if value
        _.isFunction(value.toJSON) && (json[name] = value.toJSON())
    )
    @_isSerializing = false
    json


  handle_error: (xhr, status, thrown) ->
    console.log xhr
    console.log status
    console.log thrown

class S98.Models.BaseCollection extends Backbone.Collection

  initialize: ->
    @ascSort = []
    @fetched = false

  search: (textToSearch, attribute, allow_partial = true) ->
    return @ if not textToSearch? or not textToSearch
    textToSearch = textToSearch.toLowerCase()
    filtered = @filter (model) ->
      attribute_value = model.get(attribute).toString().toLowerCase()
      if allow_partial
        attribute_value.indexOf(textToSearch) != -1
      else
        attribute_value is textToSearch
    @wrap(filtered)

  multiFieldSearch: (textToSearch, attributes...) ->
    textToSearch = textToSearch.toLowerCase()
    filtered = @filter (model) ->
        values = (model.get(attribute).toLowerCase().indexOf textToSearch for attribute in attributes)
        return _.uniq(values).length > 1
    @wrap(filtered)

  wrap: (obj) ->
    alert 'Wrap function needs override on ' + @__proto__.constructor.name

  customSort: (attribute) ->
    @comparator = (model) ->
      model.get(attribute)

    @sort({silent:true})
    if not @ascSort[attribute]
      @models = @models.reverse()

    @ascSort[attribute] = !@ascSort[attribute] ? true
    @trigger('reset')

  fetch: (options) ->
    that = @
    #Respects the success function passed as argument, if any
    if options?.success?
      fn = options.success
      options.success = (response) ->
        that.fetched = true
        fn.call response
    else
      options?.success = ->
        that.fetched = true
    super options

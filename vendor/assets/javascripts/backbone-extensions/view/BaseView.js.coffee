class S98.Views.BaseView extends Backbone.View

  initialize: (target) ->
    _.bindAll(@, "render")
    target.bind(method, @render, @) for method in ['add', 'change', 'reset'] if target?
    @innerViews = []

  close: (target) ->
    innerView?.close() for innerView in @innerViews if @innerViews?
    @remove()
    @unbind()

class S98.Views.BaseSingleModelView extends S98.Views.BaseView

  initialize: ->
    super @model

  close: ->
    super @model

class S98.Views.BaseCollectionView extends S98.Views.BaseView

  initialize: ->
    super @collection
    @current_page = 0
    @entries_per_page = 20
    @total = 0
    @paginated_collection = null

  paginate: ->
    @total = @collection.length
    start_index = @current_page * @entries_per_page
    end_index = start_index + @entries_per_page
    if @total > @entries_per_page
      @paginated_collection = @current_collection.wrap @current_collection[start_index..end_index-1]
    else
      @paginated_collection = @current_collection
    @renderList @paginated_collection
    @update_pagination_info(start_index + 1, Math.min(end_index,@current_collection.length), @current_collection.length)

  update_pagination_info: (start,end,total) ->
    alert 'update_pagination_info function needs override on ' + @__proto__.constructor.name

  previous_page: ->
    if @current_page > 0
      @current_page--
      @paginate()

  next_page: ->
    if (@current_page+1) * @entries_per_page < @current_collection.length
      @current_page++
      @paginate()

  reset_pagination: ->
    @current_page = 0
    @paginate()

  close: ->
    super @collection

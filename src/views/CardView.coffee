class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    # @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
    if @model.get 'revealed'
      @$el.css({
        'background-image': "url(img/cards2/#{@model.get('rankName')}_of_#{@model.get('suitName')}.png)"
      })


class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text if not @collection.isDealer and @collection.scores()[0] isnt @collection.scores()[1] and @collection.scores()[1] <= 21 then "#{@collection.scores()[0]}/#{@collection.scores()[1]}" else @collection.winningScore()


class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="deal-button" disabled>Deal</button> <span class="game-result"></span>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('game').get('playerHand').hit()
    'click .stand-button': -> @model.get('game').get('playerHand').stand()
    'click .deal-button': -> @model.get('game').set 'gameOver', false

  initialize: ->
    @render()
    @model.get('game').on 'change:gameOver', =>
      @$el.find('button').attr 'disabled', @model.get('game').get 'gameOver'
      @$el.find('button.deal-button').attr 'disabled', not @model.get('game').get 'gameOver'
    @model.get('game').on 'change:gameResult', =>
      @$el.find('span.game-result').text @model.get('game').get 'gameResult'
    @model.get('game').scoreGame()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get('game').get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get('game').get 'dealerHand').el


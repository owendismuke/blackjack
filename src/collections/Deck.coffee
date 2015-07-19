class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @shuffle()
    @listenTo @, 'remove', ->
      @trigger 'shuffleMe' if @length < 18


  dealPlayer: -> new Hand [@pop(), @pop()], @

  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true

  shuffle: ->
    @reset _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)
    console.log 'shuffled'

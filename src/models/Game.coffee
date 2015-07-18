class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', player = deck.dealPlayer()
    @set 'dealerHand', dealer = deck.dealDealer()
    @set 'gameOver', false
    @listenTo player, 'stand', @startDealer
    @listenTo player, 'add', @scorePlayer
    @scoreGame()

  startDealer: ->
    @set 'gameOver', true
    dealer = @get 'dealerHand'
    dealer.at(0).flip()
    dealer.hit() while dealer.minScore() < 17

  scorePlayer: ->
    player = @get 'playerHand'
    @set 'gameOver' , @isBusted player.minScore()

  isBusted: (score) ->
    score > 21

  isBlackjack: (hand) ->
    card1 = hand.at(0).get 'value'
    card2 = hand.at(1).get 'value'
    card1 + card2 is 11 and hand.hasAce()

  scoreGame: ->
    player = @get 'playerHand'
    dealer = @get 'dealerHand'

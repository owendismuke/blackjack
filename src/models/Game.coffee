class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', player = deck.dealPlayer()
    @set 'dealerHand', dealer = deck.dealDealer()
    @set 'gameOver', false
    @set 'gameResult', ''
    @listenTo player, 'stand', @startDealer
    @listenTo player, 'add', @scorePlayer

  startDealer: ->
    @set 'gameOver', true
    dealer = @get 'dealerHand'
    dealer.at(0).flip()
    dealer.hit() while dealer.minScore() < 17
    @scoreGame()

  scorePlayer: ->
    player = @get 'playerHand'
    if @isBusted player.minScore()
      @set 'gameOver', true
      @scoreGame()


  isBusted: (score) ->
    score > 21

  isBlackjack: (hand) ->
    if hand.length isnt 2 then false
    card1 = hand.at(0).get 'value'
    card2 = hand.at(1).get 'value'
    card1 + card2 is 11 and hand.hasAce()

  scoreGame: ->
    player = @get 'playerHand'
    dealer = @get 'dealerHand'
    dealer.at(0).flip() if @isBlackjack(dealer)
    @set 'gameOver', true if @isBlackjack(dealer) or @isBlackjack(player)
    return @set 'gameResult', 'Dealer Blackjack' if @isBlackjack(dealer) and not @isBlackjack(player)
    return @set 'gameResult', 'Player Blackjack' if @isBlackjack(player) and not @isBlackjack(dealer)
    return @set 'gameResult', 'Push' if @isBlackjack(player) and @isBlackjack(dealer)
    if @get 'gameOver'
      return @set 'gameResult', 'Push' if player.winningScore() is dealer.winningScore()
      return @set 'gameResult', 'Player Bust' if @isBusted player.minScore()
      return @set 'gameResult', 'Dealer Bust' if @isBusted dealer.minScore()
      return @set 'gameResult', if player.winningScore() > dealer.winningScore() then 'Player Wins' else 'Dealer Wins'

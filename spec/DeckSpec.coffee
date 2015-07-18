assert = chai.assert
expect = chai.expect

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    sinon.spy hand, 'trigger'

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 50
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 49

  describe 'stand', ->
    it 'should trigger a stand event on the hand', ->
      hand.stand()
      expect hand.trigger
      .to
      .have
      .been
      .calledWith 'stand'
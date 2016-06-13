Helper = require('hubot-test-helper')
expect = require('chai').expect
nock = require('nock')

helper = new Helper('../src/marvin-hearthstoneapi.coffee')

describe 'Search for cards', ->
  beforeEach ->
    @room = helper.createRoom()
    nock( 'https://omgvamp-hearthstone-v1.p.mashape.com')
      .get('/cards/search/leeroy')
      .reply 200, [
          {
            "cardId": "EX1_116",
            "name": "Leeroy Jenkins",
            "cardSet": "Classic",
            "type": "Minion",
            "faction": "Alliance",
            "rarity": "Legendary",
            "cost": 5,
            "attack": 6,
            "health": 2,
            "text": "<b>Charge</b>. <b>Battlecry:</b> Summon two 1/1 Whelps for your opponent.",
            "flavor": "At least he has Angry Chicken.",
            "artist": "Gabe from Penny Arcade",
            "collectible": true,
            "elite": true,
            "img": "http://wow.zamimg.com/images/hearthstone/cards/enus/original/EX1_116.png",
            "imgGold": "http://wow.zamimg.com/images/hearthstone/cards/enus/animated/EX1_116_premium.gif",
            "locale": "enUS",
            "mechanics": [
              {
                "name": "Charge"
              },
              {
                "name": "Battlecry"
              }
            ]
          }
      ]

  afterEach ->
    @room.destroy()
    nock.cleanAll()

  it 'hears .hs search', ->
    @room.user.say('bob', '.hs search leeroy').then =>
      expect(@room.messages).to.eql [
        ['bob', '.hs search leeroy']
        ['hubot',
            "Leeroy Jenkins http://wow.zamimg.com/images/hearthstone/cards/enus/original/EX1_116.png"
        ]
      ]


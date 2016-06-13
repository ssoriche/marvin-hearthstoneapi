# Description
#   Interacts with hearthstoneapi.com
#
# Configuration:
#   HUBOT_MASHAPE_KEY
#
# Commands:
#   .hs search <card> - <what the hear trigger does>
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   Shawn Sorichetti <ssoriche@gmail.com>

urlBase = 'https://omgvamp-hearthstone-v1.p.mashape.com'

module.exports = (robot) ->
  robot.hear /^[\.!]hs search\s+(.*)$/i, (msg) ->
    [ __, cardName ] = msg.match

    robot.http(urlBase + "/cards/search/" + encodeURI(cardName))
      .header('Accept', 'application/json')
      .header("X-Mashape-Key", process.env.HUBOT_MASHAPE_KEY)
      .get() (err, res, body) ->
        cards = JSON.parse body
        if Object.keys(cards).length == 1
          reply = cards[0].name + " " + cards[0].img
          msg.send reply

# Description
#   A hubot script for miscellaneous Slack utilities.
#
# Configuration:
#   HUBOT_SLACK_TOKEN
#   HUBOT_BOT_NAME
#
# Commands:
#   slack delete last [<count>] - <Delete the last (N) Hubot posts in the current room>
#
# Author:
#   brianantonelli <brian.antonelli@autotrader.com>

request = require('request')
token = process.env.HUBOT_SLACK_TOKEN
botname = process.env.HUBOT_BOT_NAME
baseURL = 'https://slack.com/api'

getHistory = (channel, cb) ->
  if (channel.substr(0,1) == "G")
    request.get {url: "#{baseURL}/groups.history?token=#{token}&channel=#{channel}&count=15", json: true}, (err, res, history) ->
      throw err if err
      cb history
  else
    request.get {url: "#{baseURL}/channels.history?token=#{token}&channel=#{channel}&count=15", json: true}, (err, res, history) ->
      throw err if err
      cb history

getUserId = (username, cb) ->
  request.get {url: "#{baseURL}/users.list?token=#{token}", json: true}, (err, res, users) ->
    throw err if err
    userid = (user for user in users.members when user.name is username)[0]
    cb userid.id

deleteMessage = (channel, ts) ->
  console.log "Deleting #{ts} on #{channel}"
  request.post {url: "#{baseURL}/chat.delete?token=#{token}&channel=#{channel}&ts=#{ts}", json: true}, (err, res, deleted) ->
    throw err if err
    console.log deleted

# Find Hubot's ID
hubotid = null
getUserId botname, (uid) ->
  hubotid = uid

module.exports = (robot) ->
  robot.respond /slack delete last\s?(\d+)?/i, (msg) ->
    count = msg.match[1]
    if not count then count = 1
    channel = msg.message.rawMessage.channel

    getHistory channel, (history) ->
      messages = (message for message in history.messages when message.user is hubotid)
      messages = messages.slice 0, count
      for msg, i in messages
        deleteMessage  channel, msg.ts
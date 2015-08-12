
# Hubot Slack Utilities [![npm version](https://badge.fury.io/js/hubot-slack-utils.svg)](http://badge.fury.io/js/hubot-slack-utils) [![Build Status](https://travis-ci.org/Cox-Automotive/hubot-slack-utils.png)](https://travis-ci.org/Cox-Automotive/hubot-slack-utils)

This script is designed to be used with a [Hubot](http://hubot.github.com) to interact with Slack.

## Adding to Your Hubot

See full instructions [here](https://github.com/github/hubot/blob/master/docs/scripting.md#npm-packages).

1. `npm install hubot-slack-utils --save` (updates your `package.json` file)
2. Open the `external-scripts.json` file in the root directory (you may need to create this file) and add an entry to the array (e.g. `[ 'hubot-slack-utils' ]`).

## Commands

- `slack delete last [<count>]` - Delete the last (N) Hubot posts in the current room or group.

## Suggested Setup

* The form fields presented there are, in order, the following Hubot environment variables:
 * `HUBOT_SLACK_TOKEN`
 * `HUBOT_BOT_NAME`
* Register the two values as environment variables when starting your bot (as usual with Hubot scripts) using `export` or `heroku config:set` or whatever applies to your Hubot hosting environment.
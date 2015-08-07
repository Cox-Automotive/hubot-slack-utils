chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'slack-utils', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/slack-utils')(@robot)

  it 'registers a response listener for deleting hubot slack messages', ->
    expect(@robot.respond).to.have.been.calledWith(/slack delete last\s?(\d+)?/i)
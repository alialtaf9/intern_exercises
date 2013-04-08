ioc = require 'socket.io-client'

CHAT_SERVER = 'http://localhost:3001'
describe 'node-chat', ->
  it 'can be connected to', (done) ->
    io = ioc.connect CHAT_SERVER
    io.on 'connect', ->
      done()
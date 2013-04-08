ioc = require 'socket.io-client'

CHAT_SERVER = 'http://localhost:3001'

clientConnection = ->
  ioc.connect CHAT_SERVER, 'force new connection': true

io = null

describe 'node-chat', ->
  beforeEach ->
    io = clientConnection()

  it 'can be connected to', (done) ->
    io.on 'connect', ->
      done()

  it 'registers names', (done) ->

    io.emit 'register_name', name: 'Tom'
    io.on 'register_name:response', (data) ->
      data.name.should.equal 'Tom'
      data.result.should.equal 'success'
      done()
  
  it 'sends out posted messages', (done) ->
    io.emit 'register_name', name: 'Kana'    
    io.on 'register_name:response', (registeringData) ->
      secondClient = clientConnection()
      secondClient.on 'connect', ->
        io.emit 'post_message', name: 'Kana', text: 'Who left the cats out?'
        secondClient.on 'new_message', (message) ->
          message.name.should.equal 'Kana'
          message.text.should.equal 'Who left the cats out?'
          done()


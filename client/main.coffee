@log = (args...) -> console.log args...
@dir = (obj) -> console.log(JSON.stringify obj)
@assert = (bool, msg) ->
  unless bool
    throw new Error('assertion failed' + if msg? then ' ' + msg else '')

@assertPlayerId = (player_id) ->
  assert(player_id in config.player_ids, "Invalid user id")

@degToRad = (deg) -> (deg * Math.PI) / 180


@zip = () ->
  lengthArray = (arr.length for arr in arguments)
  length = Math.max(lengthArray...)
  for i in [0...length]
    arr[i] for arr in arguments


createPaper = (paperId, width, height, opacity) ->
  paper = Raphael(paperId, width, height)
  background = paper.rect(0, 0, width, height)
  background.attr({fill: '#000', opacity: opacity})
  paper


setupNow = (game) ->

  now.displayMessage = (msg) ->
    log "received message: #{msg}"
    $('#log').append($('<p>').text(msg))

  now.receiveAngle = (args...) -> game.setAngle args...
  now.receiveShot = (args...) -> game.shot args...
  now.receiveShotFinished = (args...) -> game.shotFinished args...  # TODO remove this
  now.receiveBallsMoved = (args...) -> game.moveBalls args...
  now.receiveBallMoved = (args...) -> game.moveBall args...
  now.receiveActivatePowerup = (args...) -> game.activatePowerup args...
  now.receiveDeactivatePowerup = (args...) -> game.deactivatePowerup args...
  now.receiveClock = (args...) -> game.clockTick args...
  now.receiveValidPull = (args...) -> game.validPull args...
  now.receiveInvalidPull = (args...) -> game.invalidPull args...
  now.receiveHealth = (args...) -> game.updateHealth args...
  now.receivePlayerDeath = (args...) -> game.killPlayer args...
  now.receiveMessage = (args...) -> game.displayMessage args...

  now.debug_receiveShadow = (args...) -> game.debugShadow args...

  now.receiveBallInTurret = (args...) -> game.ballInTurret args...


setupChat = ->

  $('#chatform').submit ->
    msg = $('#chatinput').val()
    $('#chatinput').val('')
    log "chat message:", msg

    now.chat msg
    false

class FpsThrottler
  constructor: (@fps) ->
    @frameTime = 1000 / @fps
    @lastEventDate = null

  throttle: (fn) ->
    if !@lastEventDate or (new Date() > new Date(@lastEventDate.getTime() + @frameTime))
      @lastEventDate = new Date()
      fn()

main = ->
  # create paper
  paper = createPaper 'paper', config.arena_size.x, config.arena_size.y, 0.3

  # create paper for statistics display
  chartPaper = createPaper 'chartPaper', 430, 120, 0
  piePaper = createPaper 'piePaper', 200, 70, 0


  vortex = new Vortex(paper)

  # create game
  arena = new Arena(paper)

  # create stats page
  statistics = new Statistics(chartPaper,piePaper)

  game = new Game(arena, statistics, 0, now)
  arena.setGame game

  num_colors = 4

  # listen to mouse events
  mouseMoveThrottler = new FpsThrottler config.mouse_move_fps
  $('#paper svg').mousemove (e) ->
    mouseMoveThrottler.throttle ->
      arena.mouseMoved e.offsetX, e.offsetY

  # listen to mouse events
  $(paper.canvas).mousedown (e) ->
    arena.mousePressed e.offsetX, e.offsetY

  # listen to mouse events
  $(paper.canvas).mouseup (e) ->
    arena.mouseReleased e.offsetX, e.offsetY

  # listen to key presses (powerup use)
  $(document).keydown (e) ->
    switch e.keyCode
      when 32 # Spacebar
        e.preventDefault()
        arena.spacebarPressed()

  $(document).bind "touchmove", (e) ->
    e.preventDefault()
    x = e.touches[0].pageX
    y = e.touches[0].pageY
    arena.mouseMoved x, y



  # Use game as toplevel knockout ViewModel
  ko.applyBindings game

  setupNow game

  now.ready ->
    log "now ready"

    setupChat()

  # Debugging global variables
  @a = arena
  @g = game
  @p = paper


$ ->
  host = window.location.hostname
  $.getScript "http://#{host}:7777/nowjs/now.js", ->
    main()


@log = (args...) ->
  console.log args...

@zip = () ->
  lengthArray = (arr.length for arr in arguments)
  length = Math.max(lengthArray...)
  for i in [0...length]
    arr[i] for arr in arguments

# Constants
FPS = 50

createPaper = (width, height) ->
  paper = Raphael('paper', width, height)  # TODO don't hardcode id here

  background = paper.rect(0, 0, width, height)
  background.attr({fill: '#000'})

  paper


setupNow = (game) ->

  now.displayMessage = (msg) ->
    log "received message: #{msg}"
    $('#log').append($('<p>').text(msg))

  now.receiveAngle = (args...) -> game.setAngle args...
  now.receivePlasmaBalls = (args...) -> game.updatePlasmaBalls args...
  now.receiveBallsEnabled = (args...) -> game.setBallsEnabled args...

setupChat = ->

  $('#chatform').submit ->
    msg = $('#chatinput').val()
    $('#chatinput').val('')
    log msg

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
  paper = createPaper 400, 400

  v = new Vortex(paper)
  v.render(paper)

  # create game
  @a = arena = new Arena(paper)

  # TODO: Need to pass in plasmaballs
  @g = game = new Game(arena, 0, now)
  arena.setGame game

  num_colors = 4

  # listen to mouse events
  mouseMoveThrottler = new FpsThrottler FPS
  $(document).mousemove (e) ->
    mouseMoveThrottler.throttle ->
      mx = e.pageX - paper.canvas.offsetLeft
      my = e.pageY - paper.canvas.offsetTop
      arena.mouseMoved(mx, my)

  # listen to mouse events
  $(paper.canvas).mousedown (e) ->
    arena.mousePressed()

  # listen to mouse events
  $(paper.canvas).mouseup (e) ->
    arena.mouseReleased()


  # Use game as toplevel knockout ViewModel
  ko.applyBindings game

  setupNow game

  now.ready ->
    log "now ready"

    setupChat()


$ ->
  host = window.location.hostname
  $.getScript "http://#{host}:7777/nowjs/now.js", ->
    main()

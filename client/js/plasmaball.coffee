class @PlasmaBall
  constructor: (@x = 0, @y = 0) ->
    log "Creating PlasmaBall"
    @time = 0

  render: (canvas) ->
    log "Rendering PlasmaBall"
    @ball = canvas.circle(canvas.width/2, canvas.height/2, 10)
            .attr({fill: '#00ff00', "stroke-opacity": 0})
    @moveIt canvas
    @moveIt canvas
    @moveIt canvas
    @moveIt canvas
    setInterval () =>
       @moveIt canvas
    , 50

  rand: (min, max) ->
    Math.floor(Math.random() * (max - min + 1)) + min

  moveIt: (canvas) ->
    log "Moving PlasmaBall"
    unless @time > 0
      @time = @rand(50, 200)
      @deg = @rand(-179, 180)
      @vel = @rand(1, 5)
      @curve = @rand(0, 1)
    dx = @vel * Math.cos (@deg * Math.PI/180)
    dy = @vel * Math.sin (@deg * Math.PI/180)
    
    @x += dx
    @y += dy
    
    if @x < 0
      @x = canvas.width + @x
    else
      @x = @x % canvas.width

    if @y < 0
      @y = canvas.height + @y
    else
      @y = @y % canvas.height

    if @curve > 0
      @deg += 2
    else
      @deg -= 2

    @ball.attr({cx: @x, cy: @y})

    @time = @time - 1
    if @vel < 1
      @time = 0
    else
      @vel = @vel - .05


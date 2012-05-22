class @Turret

  # Positions are clockwise from top left to bottom left
  # 0 => TL, 1 => TR, 2 => BR, 3 => BL
  constructor: (@position, @canvas) ->
    log "Creating #{@name()}"


    @image = "../images/double_turret.png"

    @width = 200
    @height = 100

    @center = switch @position
      when 0 then {x: 0, y: 0}
      when 1 then {x: @canvas.width, y: 0}
      when 2 then {x: @canvas.width, y: @canvas.height}
      when 3 then {x: 0, y: @canvas.height}

    xoffset = 30
    yoffset = 50
    @offset_center = switch @position
      when 0 then {x: -xoffset, y: -yoffset}
      when 1 then {x: @canvas.width - xoffset, y: -yoffset}
      when 2 then {x: @canvas.width - xoffset, y: @canvas.height - yoffset }
      when 3 then {x: -xoffset, y: @canvas.height - yoffset}

    @angle = @position * 90# + 45

    @setup()

  name: ->
    "Turret #{@position}"

  # takes a raphael canvas c
  setup: ->
    log "Rendering #{@name()}"

    # simple body (circle!)
    @body_sprite = @canvas.circle(@center.x, @center.y, 80)
                    .attr({fill: '#CCCCCC'})

    @turret_sprite = @canvas.image(@image, @offset_center.x, @offset_center.y, @width, @height)
                      .transform("r#{@angle},#{@center.x},#{@center.y}")

  mouseMoved: (mx, my) ->
    dx = @offset_center.x - mx
    dy = @offset_center.y - my

    a = Math.atan(Math.abs(dy/dx))
    if dx > 0 and dy > 0
      angle = Math.PI + a
    else if dx > 0
      angle = Math.PI - a
    else if dy > 0
      angle = 2 * Math.PI - a
    else
      angle = a
    angle_degrees = angle * (180 / Math.PI)
    @setTurretRotation angle_degrees

  # sets the turret rotation based on the given angle (in degrees)
  setTurretRotation: (angle) ->
    @angle = angle
    @turret_sprite.transform("R#{@angle},#{@center.x},#{@center.y}")

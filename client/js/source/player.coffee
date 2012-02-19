loadPlayer = -> 
  player = Crafty.e("2D, Canvas, player, Controls, CustomControls, Animate, Collision").attr(
    x: 160
    y: 144
    z: 1
  ).CustomControls(1).animate("walk_left", 6, 3, 8).animate("walk_right", 9, 3, 11).animate("walk_up", 3, 3, 5).animate("walk_down", 0, 3, 2).bind("EnterFrame", (e) ->
    if @isDown("LEFT_ARROW")
      @stop().animate "walk_left", 10  unless @isPlaying("walk_left")
    else if @isDown("RIGHT_ARROW")
      @stop().animate "walk_right", 10  unless @isPlaying("walk_right")
    else if @isDown("UP_ARROW")
      @stop().animate "walk_up", 10  unless @isPlaying("walk_up")
    else @stop().animate "walk_down", 10  unless @isPlaying("walk_down")  if @isDown("DOWN_ARROW")
  ).bind("Keyup", (e) ->
    @stop()
  ).collision().onHit("wall_left", ->
    @x += @_speed
    @stop()
  ).onHit("wall_right", ->
    @x -= @_speed
    @stop()
  ).onHit("wall_bottom", ->
    @y -= @_speed
    @stop()
  ).onHit("wall_top", ->
    @y += @_speed
    @stop()
  )
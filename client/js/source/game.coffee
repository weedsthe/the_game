loadControls = ->  
  Crafty.c "CustomControls",
    __move:
      left: false
      right: false
      up: false
      down: false

    _speed: 3

    init: ->
      @requires "SpriteAnimation"
      @requires "Keyboard"

    CustomControls: (speed) ->
      @_speed = speed  if speed
      move = @__move
      @bind "EnterFrame", ->            
        if @isDown("RIGHT_ARROW")
          @x += @_speed
        else if @isDown("LEFT_ARROW")
          @x -= @_speed
        else if @isDown("UP_ARROW")
          @y -= @_speed
        else @y += @_speed  if @isDown("DOWN_ARROW")

loadMisc = ->
  Crafty.scene "loading", ->
    Crafty.load [ "client/images/sprite.png" ], ->
      Crafty.scene "main"
    
    Crafty.background "#000"
    Crafty.e("2D, DOM, Text").attr(
      w: 100
      h: 20
      x: 150
      y: 120
    ).text("Loading").css "text-align" : "center"

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
  ).onHit("obstacles", ->
    if @isPlaying "walk_up"
      @y += @_speed
    else if @isPlaying "walk_down" 
      @y -= @_speed
    else if @isPlaying "walk_right" 
      @x -= @_speed
    else if @isPlaying "walk_left" 
      @x += @_speed
      
    @stop()
  )
  
loadSprites = ->
  Crafty.sprite 16, "client/images/sprite.png",
    grass1: [ 0, 0 ]
    grass2: [ 1, 0 ]
    grass3: [ 2, 0 ]
    grass4: [ 3, 0 ]
    flower: [ 0, 1 ]
    bush1: [ 0, 2 ]
    bush2: [ 1, 2 ]
    player: [ 0, 3 ]
    
generateWorld = ->
  _(_.range(25)).each (i) ->
    _(_.range(21)).each (j) ->

      grassType = Crafty.math.randomInt(1, 4)
      Crafty.e("2D, Canvas, grass"+grassType).attr
        x: i * 16 
        y: j * 16
        
      if i%2 == 0 and j%2 == 0
        Crafty.e("2D, DOM, obstacles, solid, bush"+ Crafty.math.randomInt(1,2)).attr
          x: i*16
          y: j*16
          z: 2         

    Crafty.e("2D, DOM, wall_top, solid, bush" + Crafty.math.randomInt(1, 2)).attr
      x: i * 16
      y: 0
      z: 2

    Crafty.e("2D, DOM, wall_bottom, solid, bush" + Crafty.math.randomInt(1, 2)).attr
      x: i * 16
      y: 320
      z: 2

    Crafty.e("2D, DOM, wall_left, solid, bush"+ Crafty.math.randomInt(1,2)).attr
      x: 0
      y: i*16
      z: 2

    Crafty.e("2D, DOM, wall_right, solid, bush"+ Crafty.math.randomInt(1,2)).attr
      x: 384
      y: i*16
      z: 2




window.onload = ->
  Crafty.init 400, 336
  Crafty.canvas.init()

  loadSprites()
  loadMisc()
  
  Crafty.scene "loading"
  Crafty.scene "main", ->
    generateWorld()
    loadControls()
    loadPlayer()

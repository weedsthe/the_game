window.onload = ->

  generateWorld = ->

    _(_.range(25)).each (i) ->
      _(_.range(20)).each (j) ->

        grassType = Crafty.math.randomInt(1, 4)
        Crafty.e("2D, Canvas, grass"+grassType).attr
          x: i * 16 
          y: j * 16 
 
        Crafty.e("2D, Canvas, wall_top, solid, bush" + Crafty.math.randomInt(1, 2)).attr
          x: i * 16
          y: 0
          z: 2

        Crafty.e("2D, DOM, wall_bottom, solid, bush" + Crafty.math.randomInt(1, 2)).attr
          x: i * 16
          y: 304
          z: 2

        Crafty.e("2D, Canvas, wall_left, solid, bush"+ Crafty.math.randomInt(1,2)).attr
          x: 0
          y: i*16
          z: 2

        Crafty.e("2D, DOM, wall_right, solid, bush"+ Crafty.math.randomInt(1,2)).attr
          x: 384
          y: i*16
          z: 2



  Crafty.init 400, 320
  Crafty.canvas.init()

  Crafty.sprite 16, "client/images/sprite.png",
    grass1: [ 0, 0 ]
    grass2: [ 1, 0 ]
    grass3: [ 2, 0 ]
    grass4: [ 3, 0 ]
    flower: [ 0, 1 ]
    bush1: [ 0, 2 ]
    bush2: [ 1, 2 ]
    player: [ 0, 3 ]

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
      

  Crafty.scene "loading"

  Crafty.scene "main", ->
    generateWorld()
    Crafty.c "Hero",
      init: ->
        @requires("SpriteAnimation, Collision").animate("walk_left", 6, 3, 8).animate("walk_right", 9, 3, 11).animate("walk_up", 3, 3, 5).animate("walk_down", 0, 3, 2).bind("NewDirection", (direction) ->
          @stop().animate "walk_left", 10, -1  unless @isPlaying("walk_left")  if direction.x < 0
          @stop().animate "walk_right", 10, -1  unless @isPlaying("walk_right")  if direction.x > 0
          @stop().animate "walk_up", 10, -1  unless @isPlaying("walk_up")  if direction.y < 0
          @stop().animate "walk_down", 10, -1  unless @isPlaying("walk_down")  if direction.y > 0
          @stop()  if not direction.x and not direction.y
        ).bind "Moved", (from) ->
          if @hit("solid")
            @attr
              x: from.x
              y: from.y

        this

    Crafty.c "RightControls",
      init: ->
        @requires "Multiway"

      rightControls: (speed) ->
        @multiway speed,
          UP_ARROW: -90
          DOWN_ARROW: 90
          RIGHT_ARROW: 0
          LEFT_ARROW: 180

        this

    player = Crafty.e("2D, Canvas, player, RightControls, Hero, Animate, Collision").attr(
      x: 160
      y: 144
      z: 1
    ).rightControls(1)

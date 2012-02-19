window.onload = ->

  generateWorld = ->
    i = 0
    while i < 25
      j = 0
      
      while j < 20
      
        grassType = Crafty.math.randomInt(1, 4)
        Crafty.e("2D, Canvas, grass"+grassType).attr
          x: i*16 
          y: i*16 

        j++
      i++
    i = 0

  Crafty.init 400, 320
  Crafty.canvas.init

  Crafty.sprite 16, "lib/images/sprite.png",
    grass1: [ 0, 0 ]
    grass2: [ 1, 0 ]
    grass3: [ 2, 0 ]
    grass4: [ 3, 0 ]
    flower: [ 0, 1 ]
    bush1: [ 0, 2 ]
    bush2: [ 1, 2 ]
    player: [ 0, 3 ]

  Crafty.scene "loading", ->
    Crafty.load "lib/images/sprite.png", ->
      Crafty.scene "main"

  Crafty.background "#000"
  Crafty.scene "loading"

  Crafty.scene "main", ->
    generateWorld()

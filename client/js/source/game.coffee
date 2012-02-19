window.onload = ->

  generateWorld = ->

    _(_.range(25)).each (i) ->
      _(_.range(20)).each (j) ->

        grassType = Crafty.math.randomInt(1, 4)
        Crafty.e("2D, Canvas, grass"+grassType).attr
          x: i * 16 
          y: j * 16 

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
  Crafty.scene "loading"

  Crafty.scene "main", ->
    generateWorld()

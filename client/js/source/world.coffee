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
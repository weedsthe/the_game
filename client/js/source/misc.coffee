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

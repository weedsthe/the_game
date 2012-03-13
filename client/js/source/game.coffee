require [ "misc", "player", "controls", "sprites", "world" ], (misc,player,controls,sprites,world)->

  window.onload = ->
    Crafty.init 400, 336, 50
    Crafty.canvas.init()

    sprites.loadSprites()
    misc.loadMisc()
    
    Crafty.scene "loading"
    Crafty.scene "main", ->
      world.generateWorld()
      controls.loadControls()
      player.loadPlayer()

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
dofile('./scripts/base_player.lua')

-- Configuration
controls = {
  up    = 101,
  down  = 103,
  left  = 100,
  right = 102
}

key_state = {
  key_pressed  = engine_testSpecialKeyPressed,
  key_released = engine_testSpecialKeyReleased,
}

-- Overridden Engine Callbacks
function on_load(this)
  setModel(this, "SailBoat.mdl")

  setRotation(this, 0.0, 1.57, 0.0)
  setScale(this, 7.0, 7.0, 7.0)
  setVelocity(this, 40.0, 0.0, 0.0)

  setTypeId(this, 0)
end

function on_update(this, elapsedTime)
  update(this, controls, key_state)
end

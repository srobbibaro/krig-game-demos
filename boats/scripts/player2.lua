dofile('./scripts/base_player.lua')

-- Configuration
controls = {
  up    = string.byte("w", 1),
  down  = string.byte("s", 1),
  left  = string.byte("a", 1),
  right = string.byte("d", 1)
}

key_state = {
  key_pressed  = engine_testKeyPressed,
  key_released = engine_testKeyReleased
}

-- Overridden Engine Callbacks
function on_load(this)
  setModel(this, "BoatCannon.mdl")

  setRotation(this, 0.0, -1.57, 0.0)
  setScale(this, 10.0, 12.0, 10.0)
  setVelocity(this, 40.0, 0.0, 0.0)

  setTypeId(this, 1)
end

function on_update(this, elapsedTime)
  update(this, controls, key_state)
end

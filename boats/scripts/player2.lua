dofile('./scripts/base_player.lua')

-- Configuration
controls = {
  up    = string.byte("w", 1),
  down  = string.byte("s", 1),
  left  = string.byte("a", 1),
  right = string.byte("d", 1)
}

key_state = {
  key_pressed  = krig.test_key_pressed,
  key_released = krig.test_key_released
}

-- Overridden Engine Callbacks
function on_load(this)
  this.rotation = krig.rotation.from_euler({0.0, -1.57, 0.0})
  this.scale    = {10.0, 12.0, 10.0}
  this.type_id  = 1
  this:save()

  this:set_model("BoatCannon.mdl")
end

function on_update(this, elapsedTime)
  update(this, controls, key_state)
end

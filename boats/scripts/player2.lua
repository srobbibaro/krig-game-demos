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
  krig.object.set_model(this, "BoatCannon.mdl")

   krig.object.set_rotation(this, 0.0, -1.57, 0.0)
   krig.object.set_scale(this, 10.0, 12.0, 10.0)
   krig.object.set_velocity(this, 40.0, 0.0, 0.0)

   krig.object.set_type_id(this, 1)
end

function on_update(this, elapsedTime)
  update(this, controls, key_state)
end

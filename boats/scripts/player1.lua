dofile('./scripts/base_player.lua')

-- Configuration
controls = {
  up    = 101,
  down  = 103,
  left  = 100,
  right = 102
}

key_state = {
  key_pressed  = krig.test_special_key_pressed,
  key_released = krig.test_special_key_released,
}

-- Overridden Engine Callbacks
function on_load(this)
  krig.object.set_model(this, "SailBoat.mdl")

  krig.object.set_rotation(this, 0.0, 1.57, 0.0)
  krig.object.set_scale(this, 7.0, 7.0, 7.0)
  krig.object.set_velocity(this, 40.0, 0.0, 0.0)

  krig.object.set_type_id(this, 0)
end

function on_update(this, elapsedTime)
  update(this, controls, key_state)
end

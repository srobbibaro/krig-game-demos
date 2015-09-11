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
  this.rotation = krig.rotation.from_euler({0.0, 1.57, 0.0})
  this.scale    = {7.0, 7.0, 7.0}
  this.type_id  = 0
  this:save()

  this:set_model("SailBoat.mdl")
end

function on_update(this, elapsedTime)
  update(this, controls, key_state)
end

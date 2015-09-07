-- Overridden Engine Callbacks
function on_load(this)
  krig.object.set_model(this, "building.mdl")
  krig.object.set_rotation(this, 0.0, 1.0, 0.0)
  krig.object.disable_collision_detection(this)
end

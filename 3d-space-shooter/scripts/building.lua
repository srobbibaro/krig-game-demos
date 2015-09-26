-- Overridden Engine Callbacks
function on_load(this)
  this:set_model("building.mdl")
  this.collision_detection_enabled = false
  this.rotation                    = krig.rotation.from_euler({0.0, 1.0, 0.0})
  this:save()
end

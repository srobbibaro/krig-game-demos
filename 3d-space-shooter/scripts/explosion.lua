-- Configuration
MAX_DURATION = 2.0
duration     = 0.0

-- Overridden Engine Callbacks
function on_load(this)
  duration = 0.0
  krig.object.set_model(this, "explosion.mdl")
  krig.object.set_scale_rate(this, 1.0, 1.0, 1.0)
  krig.object.disable_collision_detection(this)
  krig.object.enable_always_lit(this)
end

function on_update(this, elapsedTime)
  duration = duration + elapsedTime

  if duration >= MAX_DURATION then
    krig.level.remove_object(this)
  end
end

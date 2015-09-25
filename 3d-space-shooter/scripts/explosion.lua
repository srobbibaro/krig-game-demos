-- Configuration
MAX_DURATION = 2.0
duration     = 0.0

-- Overridden Engine Callbacks
function on_load(this)
  duration                         = 0.0
  this.scale_rate                  = {1.0, 1.0, 1.0}
  this.collision_detection_enabled = true
  this.always_lit                  = true
  this:save()

  this:set_model("explosion.mdl")
end

function on_update(this, elapsedTime)
  duration = duration + elapsedTime

  if duration >= MAX_DURATION then
    krig.level.remove_object(this)
  end
end

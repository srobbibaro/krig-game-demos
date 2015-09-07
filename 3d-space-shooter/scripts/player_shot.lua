-- Configuration
MAX_DURATION = 3.0
duration     = 0.0

-- Overridden Engine Callbacks
function on_load(this)
  krig.object.set_model(this, "blueshot.mdl")
  krig.object.set_type_id(this, 2)
  krig.object.enable_always_lit(this)

  krig.play_sound(this, "laser.wav")
end

function on_update(this, elapsedTime)
  duration = duration + elapsedTime

  if duration > MAX_DURATION then
    krig.level.remove_object(this)
    duration = 0.0
  end
end

function on_collision(this, temp)
  typeId = krig.object.get_type_id(temp)

  if typeId ~= 0 and typeId ~= 10 then
    krig.level.remove_object(this)
    duration = 0.0
  end
end

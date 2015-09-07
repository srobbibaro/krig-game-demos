MAX_DURATION = 5.0
duration     = 0.0

-- Overridden Engine Callbacks
function on_load(this)
  krig.object.set_model(this, "greenshot.mdl")
  krig.object.set_type_id(this, 10)
  krig.object.enable_always_lit(this)

  krig.play_sound(this, "laser.wav")
end

function on_update(this, elapsedTime)
  duration = duration + elapsedTime

  if duration > MAX_DURATION then
    krig.level.remove_object(this)
    duration = 0
  end
end

function on_collision(this, temp)
  typeId = krig.object.get_type_id(temp)

  if typeId ~= 1 and typeId ~= 3 and typeId ~= 2 then
    krig.level.remove_object(this)
    duration = 0
  end
end

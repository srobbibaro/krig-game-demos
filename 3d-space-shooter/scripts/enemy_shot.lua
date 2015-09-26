MAX_DURATION = 5.0
duration     = 0.0

-- Overridden Engine Callbacks
function on_load(this)
  this.type_id    = 10
  this.always_lit = true
  this:save()

  this:set_model("greenshot.mdl")

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
  if temp.type_id ~= 1 and temp.type_id ~= 3 and temp.type_id ~= 2 then
    krig.level.remove_object(this)
    duration = 0
  end
end

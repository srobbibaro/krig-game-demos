-- Configuration
MAX_DURATION = 3.0
duration     = 0.0

-- Overridden Engine Callbacks
function on_load(this)
  this.type_id    = 2
  this.always_lit = true
  this:save()

  this:set_model("blueshot.mdl")

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
  temp = temp:load()

  if temp.type_id ~= 0 and temp.type_id ~= 10 then
    krig.level.remove_object(this)
    duration = 0.0
  end
end

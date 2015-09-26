-- Overridden Engine Callbacks
function on_load(this)
  this:set_model("greenshot.mdl")

  this.type_id    = 20
  this.always_lit = true
  this.scale      = {18.0, 18.0, 18.0}
  this:save()

  krig.play_sound(this, "laser.wav")
end

function on_update(this, elapsedTime)
  this = this:load()

  if this.in_view == 0 then
    krig.level.remove_object(this)
  end
end

function on_collision(this, temp)
  temp = temp:load()

  if temp.type_id ~= 1 and temp.type_id ~= 3 and temp.type_id ~= 2 then
    krig.level.remove_object(this)
  end
end

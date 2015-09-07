-- Overridden Engine Callbacks
function on_load(this)
  krig.object.set_model(this, "greenshot.mdl")
  krig.object.set_type_id(this, 20)
  krig.object.enable_always_lit(this)

  krig.play_sound(this, "laser.wav")
  krig.object.set_scale(this, 18.0, 18.0, 18.0)
end

function on_update(this, elapsedTime)
  in_view = krig.object.get_in_view(this)

  if in_view == 0 then
    krig.level.remove_object(this)
  end
end

function on_collision(this, temp)
  typeId = krig.object.get_type_id(temp)

  if typeId ~= 1 and typeId ~= 3 and typeId ~= 2 then
    krig.level.remove_object(this)
  end
end

MAX_DURATION = 5.0
duration     = 0.0

-- Overridden Engine Callbacks
function on_load(this)
  setModel(this, "greenshot.mdl")
  setTypeId(this, 10)
  enableAlwaysLit(this)

  playSound(this, "laser.wav")
end

function on_update(this, elapsedTime)
  duration = duration + elapsedTime

  if duration > MAX_DURATION then
    removeObject(this)
    duration = 0
  end
end

function on_collision(this, temp)
  typeId = getTypeId(temp)

  if typeId ~= 1 and typeId ~= 3 and typeId ~= 2 then
    removeObject(this)
    duration = 0
  end
end

function on_unload(this) end

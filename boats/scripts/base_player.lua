control_pressed = {
  up    = 0,
  down  = 0,
  left  = 0,
  right = 0
}

function update(this, controls, key_state)
  orientOnTerrain(this, 0.0, 0.0, 0.0)

  this_velocity   = getVelocity(this)
  camera          = getCamera()
  camera_velocity = getVelocity(camera)

  this_velocity[1] = camera_velocity[1]
  this_velocity[2] = camera_velocity[2]
  this_velocity[3] = camera_velocity[3]

  for k, v in pairs(controls) do
    if key_state.key_pressed(v) == 1 then
      control_pressed[k] = 1
    end
    if key_state.key_released(v) == 1 then
      control_pressed[k] = 0
    end
  end

  if control_pressed["up"]    == 1 then this_velocity[3] = this_velocity[3] - 25 end
  if control_pressed["down"]  == 1 then this_velocity[3] = this_velocity[3] + 25 end
  if control_pressed["left"]  == 1 then this_velocity[1] = this_velocity[1] - 25 end
  if control_pressed["right"] == 1 then this_velocity[1] = this_velocity[1] + 25 end

  setVelocityv(this, this_velocity)

  restrict_to_view(this)
end

function restrict_to_view(this)
  this_pos = getPosition(this)

  -- Ax + By + Cz + D = 0
  plane = camera_getFrustumPlane(1)
  x     = -(((plane[3] * this_pos[3]) + plane[4]) / plane[1])

  if this_pos[1] > x - getBoundingSphereRadius(this) then
    this_pos[1] = x - getBoundingSphereRadius(this)
  end

  plane = camera_getFrustumPlane(0)
  x     = -(((plane[3] * this_pos[3]) + plane[4]) / plane[1])

  if this_pos[1] < x + getBoundingSphereRadius(this) then
    this_pos[1] = x + getBoundingSphereRadius(this)
  end

  if this_pos[3] > 0 then
    this_pos[3] = 0
  end

  if this_pos[3] < -140 then
    this_pos[3] = -140
  end

  setPositionv(this, this_pos)
end

function on_collision(this,temp)
  tempId = getTypeId(temp)
  if temp_id == 100 then
    orientOnTerrain(this, 0.0, 0.0, 0.0)
  end
end

function on_unload(this, temp) end
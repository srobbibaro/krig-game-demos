next_shot_time         = 1.0
initial_next_shot_time = 1.0
script                 = nil

function setupShots(this, objectScript, initialNextShotTime)
  script                 = objectScript
  initial_next_shot_time = initialNextShotTime
  next_shot_time         = initial_next_shot_time
end

function setShot(this, script, dir_offset, up_offset)
  if up_offset == nil then up_offset = 0 end
  if dir_offset == nil then dir_offset = 0 end

  this = this:load()

  obj = krig.level.add_object(script)

  this.direction[1] = this.direction[1] * dir_offset
  this.direction[2] = this.direction[2] * dir_offset
  this.direction[3] = this.direction[3] * dir_offset

  this.up[1] = this.up[1] * up_offset
  this.up[2] = this.up[2] * up_offset
  this.up[3] = this.up[3] * up_offset

  this.position[1] = this.position[1] + this.direction[1] + this.up[1]
  this.position[2] = this.position[2] + this.direction[2] + this.up[2]
  this.position[3] = this.position[3] + this.direction[3] + this.up[3]

  obj.position = {this.position[1], this.position[2], this.position[3]}

  --speed = krig.vector.get_scalar(this_velocity, this_direction) + 25.0
  speed = 30.0

  obj.rotation          = krig.rotation.copy(this.rotation)
  obj.rotation_velocity = {this.direction[1] * 8.0, this.direction[2] * 8.0, this.direction[3] * 8.0}

  -- logic here needs to be fixed
  obj.speed = {speed, 0.0, 0.0}

  obj:save()

  return obj
end

function setShotNew(this, obj, dir_offset, up_offset)
  if up_offset == nil then up_offset = 0 end
  if dir_offset == nil then dir_offset = 0 end

  this = this:load()

  this.direction[1] = this.direction[1] * dir_offset
  this.direction[2] = this.direction[2] * dir_offset
  this.direction[3] = this.direction[3] * dir_offset

  this.up[1] = this.up[1] * up_offset
  this.up[2] = this.up[2] * up_offset
  this.up[3] = this.up[3] * up_offset

  this.position[1] = this.position[1] + this.direction[1] + this.up[1]
  this.position[2] = this.position[2] + this.direction[2] + this.up[2]
  this.position[3] = this.position[3] + this.direction[3] + this.up[3]

  obj.position = {this.position[1], this.position[2], this.position[3]}

  --speed = krig.vector.get_scalar(this_velocity, this_direction) + 25.0
  speed = 75

  obj.rotation          = krig.rotation.copy(this.rotation)
  obj.rotation_velocity = {this.direction[1] * 8.0, this.direction[2] * 8.0, this.direction[3] * 8.0}

  -- logic here needs to be fixed
  obj.speed = {speed, 0.0, 0.0}

  obj:save()

  return obj
end

function setShotWithDirectionNew(this, obj, direction, dir_offset, up_offset)
  if up_offset == nil then up_offset = 0 end
  if dir_offset == nil then dir_offset = 0 end

  this = this:load()

  this.direction[1] = this.direction[1] * dir_offset
  this.direction[2] = this.direction[2] * dir_offset
  this.direction[3] = this.direction[3] * dir_offset

  this.up[1] = this.up[1] * up_offset
  this.up[2] = this.up[2] * up_offset
  this.up[3] = this.up[3] * up_offset

  this.position[1] = this.position[1] + this.direction[1] + this.up[1]
  this.position[2] = this.position[2] + this.direction[2] + this.up[2]
  this.position[3] = this.position[3] + this.direction[3] + this.up[3]

  obj.position = this.position

  --speed = vector_getScalar(this_velocity, this_direction) + 25.0
  speed = 25

  obj.rotation = krig.rotation.copy(this.rotation)
  obj.rotation_velocity = {this.direction[1] * 8.0, this.direction[2] * 8.0, this.direction[3] * 8.0}

  -- logic here needs to be fixed
  obj.speed = {speed, 0.0, 0.0}

  obj:save()

  return obj
end

function update_shots(elapsedTime)
  next_shot_time = next_shot_time - elapsedTime
end

function attemptShot(this, dir_offset, up_offset)
  if next_shot_time <= 0.0 then
    shot = krig.level.add_object(script)
    setShotNew(this, shot, dir_offset, up_offset)
    next_shot_time = initial_next_shot_time
  end
end

function attemptShotWithDirection(this, direction, dir_offset, up_offset)
  if next_shot_time <= 0.0 then
    shot = krig.level.add_object(script)
    setShotWithDirectionNew(this, shot, direction, dir_offset, up_offset)
    next_shot_time = initial_next_shot_time
  end
end

function attemptShots(this, num_shots, dir_offset, up_offset)
  if num_shots == nil then num_shots = 1 end

  if next_shot_time <= 0.0 then
    for i = 1, num_shots do
      shot = krig.level.add_object(script)
      setShotNew(this, shot, dir_offset[i], up_offset[i])
    end
    next_shot_time = initial_next_shot_time
  end
end

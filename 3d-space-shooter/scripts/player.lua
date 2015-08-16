dofile('./scripts/base_shooting_object.lua')

-- Configuration
progress = 0
life     = 10
lives    = 5

invul            = 0.0
collisionRecover = 0

control_pressed = {
  up    = 0,
  down  = 0,
  left  = 0,
  right = 0
}

controls = {
  up    = 101,
  down  = 103,
  left  = 100,
  right = 102
}

add_rotations = {
  up    = {0.05 , 0.0  , 0.0},
  down  = {-0.05, 0.0  , 0.0},
  left  = {0.0  , 0.05 , 0.0},
  right = {0.0  , -0.05, 0.0}
}

sub_rotations = {
  up    = {-0.05, 0.0  , 0.0},
  down  = {0.05 , 0.0  , 0.0},
  left  = {0.0  , -0.05, 0.0},
  right = {0.0  , 0.05 , 0.0}
}

key_state = {
  key_pressed  = engine_testSpecialKeyPressed,
  key_released = engine_testSpecialKeyReleased,
}

-- Overridden Engine Callbacks
function on_load(this)
  setModel(this, "arwing.mdl")

  setRotation(this, 0.0, 3.14, 0.0)
  setScale(this, 2.0, 2.0, 2.0)

  setVelocity(this, 0.0, 0.0, -20.0)

  setTypeId(this, 0)

  setupShots(this, "./scripts/player_shot.lua", 0.25)
end

function on_update(this, elapsedTime)
  update_shots(elapsedTime)

  -- handle invul --
  if invul > 0.0 then invul = invul - elapsedTime end
  if collisionRecover == 1 then
    isDrawn = getDrawEnabled(this)

    if isDrawn == 0 then
      enableDraw(this)
    else
      disableDraw(this)
    end

    if invul <= 0.0 then
      enableDraw(this)
      collisionRecover = 0
    end
  end

  this_position = getPosition(this)
  this_velocity = getVelocity(this)

  camera          = getCamera()
  camera_velocity = getVelocity(camera)

  this_velocity[1] = camera_velocity[1]
  this_velocity[2] = camera_velocity[2]
  this_velocity[3] = camera_velocity[3]

  for k, v in pairs(controls) do
    if key_state.key_pressed(v) == 1 then
      control_pressed[k] = 1
      addRotationv(this, add_rotations[k])
    end
    if key_state.key_released(v) == 1 then
      control_pressed[k] = 0
      addRotationv(this, sub_rotations[k])
    end
  end

  if control_pressed["up"]    == 1 then
    this_velocity[2] = this_velocity[2] + 10
  end
  if control_pressed["down"]  == 1 then
    this_velocity[2] = this_velocity[2] - 10
  end
  if control_pressed["left"]  == 1 then
    this_velocity[1] = this_velocity[1] - 10
  end
  if control_pressed["right"] == 1 then
    this_velocity[1] = this_velocity[1] + 10
  end

  setVelocityv(this, this_velocity)

  if engine_testKeyPressed(32) == 1 then
    attemptShot(this, (getBoundingSphereRadius(this) - 1.0))
  end

  restrict_to_view(this)
end

function on_collision(this, temp)
  tempId = getTypeId(temp)

  if collisionRecover == 0 and (tempId == 1 or tempId == 10 or tempId == 4) then
    life = life - 1
    collisionRecover = 1
    invul = 1.0
    if life <= 0 then
      life = 10
      if lives > 0 then lives = lives - 1 end
    end
  elseif collisionRecover == 0 and tempId == 20 then
    life = life - 2
    collisionRecover = 1
    invul = 1.0
    if life <= 0 then
      life = 10
      if lives > 0 then lives = lives - 1 end
    end
  end
end

function on_unload(this, temp) end

-- Helper functions
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

  plane = camera_getFrustumPlane(2)
  y     = -(((plane[3] * this_pos[3]) + plane[4]) / plane[2])

  if this_pos[2] < y + getBoundingSphereRadius(this) then
    this_pos[2] = y + getBoundingSphereRadius(this)
  end

  plane = camera_getFrustumPlane(3)
  y     = -(((plane[3] * this_pos[3]) + plane[4]) / plane[2])

  if this_pos[2] > y - getBoundingSphereRadius(this) then
    this_pos[2] = y - getBoundingSphereRadius(this)
  end

  setPositionv(this, this_pos)
end

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
  key_pressed  = krig.test_special_key_pressed,
  key_released = krig.test_special_key_released,
}

-- Overridden Engine Callbacks
function on_load(this)
  krig.object.set_model(this, "arwing.mdl")

  krig.object.set_rotation(this, 0.0, 3.14, 0.0)
  krig.object.set_scale(this, 2.0, 2.0, 2.0)

  krig.object.set_velocity(this, 0.0, 0.0, -20.0)

  krig.object.set_type_id(this, 0)

  setupShots(this, "./scripts/player_shot.lua", 0.25)
end

function on_update(this, elapsedTime)
  update_shots(elapsedTime)

  -- handle invul --
  if invul > 0.0 then invul = invul - elapsedTime end
  if collisionRecover == 1 then
    isDrawn = krig.object.get_draw_enabled(this)

    if isDrawn == 0 then
      krig.object.enable_draw(this)
    else
      krig.object.disable_draw(this)
    end

    if invul <= 0.0 then
      krig.object.enable_draw(this)
      collisionRecover = 0
    end
  end

  this_position = krig.object.get_position(this)
  this_velocity = krig.object.get_velocity(this)

  camera          = krig.get_camera()
  camera_velocity = krig.object.get_velocity(camera)

  this_velocity[1] = camera_velocity[1]
  this_velocity[2] = camera_velocity[2]
  this_velocity[3] = camera_velocity[3]

  for k, v in pairs(controls) do
    if key_state.key_pressed(v) == 1 then
      control_pressed[k] = 1
      krig.object.add_rotation(this, add_rotations[k])
    end
    if key_state.key_released(v) == 1 then
      control_pressed[k] = 0
      krig.object.add_rotation(this, sub_rotations[k])
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

  krig.object.set_velocity(this, this_velocity)

  if krig.test_key_pressed(32) == 1 then
    attemptShot(this, (krig.object.get_bounding_sphere_radius(this) - 1.0))
  end

  restrict_to_view(this)
end

function on_collision(this, temp)
  tempId = krig.object.get_type_id(temp)

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

-- Helper functions
function restrict_to_view(this)
  this_pos = krig.object.get_position(this)

  -- Ax + By + Cz + D = 0
  plane = krig.camera.get_frustum_plane(1)
  x     = -(((plane[3] * this_pos[3]) + plane[4]) / plane[1])

  if this_pos[1] > x - krig.object.get_bounding_sphere_radius(this) then
    this_pos[1] = x - krig.object.get_bounding_sphere_radius(this)
  end

  plane = krig.camera.get_frustum_plane(0)
  x     = -(((plane[3] * this_pos[3]) + plane[4]) / plane[1])

  if this_pos[1] < x + krig.object.get_bounding_sphere_radius(this) then
    this_pos[1] = x + krig.object.get_bounding_sphere_radius(this)
  end

  plane = krig.camera.get_frustum_plane(2)
  y     = -(((plane[3] * this_pos[3]) + plane[4]) / plane[2])

  if this_pos[2] < y + krig.object.get_bounding_sphere_radius(this) then
    this_pos[2] = y + krig.object.get_bounding_sphere_radius(this)
  end

  plane = krig.camera.get_frustum_plane(3)
  y     = -(((plane[3] * this_pos[3]) + plane[4]) / plane[2])

  if this_pos[2] > y - krig.object.get_bounding_sphere_radius(this) then
    this_pos[2] = y - krig.object.get_bounding_sphere_radius(this)
  end

  krig.object.set_position(this, this_pos)
end

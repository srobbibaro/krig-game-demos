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
  this:set_model("arwing.mdl")

  this.rotation = krig.rotation.from_euler({0.0, 3.14, 0.0})
  this.scale    = {2.0, 2.0, 2.0}
  this.velocity = {0.0, 0.0, -20.0}
  this.type_id  = 0
  this:save()

  setupShots(this, "./scripts/player_shot.lua", 0.25)
end

function on_update(this, elapsedTime)
  update_shots(elapsedTime)

  this   = this:load()
  camera = krig.get_camera():load()

  -- handle invul --
  if invul > 0.0 then invul = invul - elapsedTime end
  if collisionRecover == 1 then
    -- Todo: fix
    this.draw_enabled = this.draw_enabled

    if invul <= 0.0 then
      this.draw_enabled = true
      collisionRecover = 0
    end
  end

  for k, v in pairs(controls) do
    if key_state.key_pressed(v) == 1 then
      control_pressed[k] = 1
      this.rotation = krig.rotation.add(this.rotation, krig.rotation.from_euler(add_rotations[k]))
    end
    if key_state.key_released(v) == 1 then
      control_pressed[k] = 0
      this.rotation = krig.rotation.add(this.rotation, krig.rotation.from_euler(sub_rotations[k]))
    end
  end

  this.velocity = krig.vector.copy(camera.velocity)

  if control_pressed["up"]    == 1 then
    this.velocity[2] = this.velocity[2] + 10
  end
  if control_pressed["down"]  == 1 then
    this.velocity[2] = this.velocity[2] - 10
  end
  if control_pressed["left"]  == 1 then
    this.velocity[1] = this.velocity[1] - 10
  end
  if control_pressed["right"] == 1 then
    this.velocity[1] = this.velocity[1] + 10
  end

  if krig.test_key_pressed(32) == 1 then
    attemptShot(this, (this.bounding_sphere_radius - 1.0))
  end

  restrict_to_view(this, camera)

  this:save()
end

function on_collision(this, temp)
  temp = temp:load()

  if collisionRecover == 0 and (temp.type_id == 1 or temp.type_id == 10 or temp.type_id == 4) then
    life = life - 1
    collisionRecover = 1
    invul = 1.0
    if life <= 0 then
      life = 10
      if lives > 0 then lives = lives - 1 end
    end
  elseif collisionRecover == 0 and temp.type_id == 20 then
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
function restrict_to_view(this, camera)
  -- Ax + By + Cz + D = 0
  plane = camera:get_frustum_plane(1)
  x     = -(((plane[3] * this.position[3]) + plane[4]) / plane[1])

  if this.position[1] > x - this.bounding_sphere_radius then
    this.position[1] = x - this.bounding_sphere_radius
  end

  plane = camera:get_frustum_plane(0)
  x     = -(((plane[3] * this.position[3]) + plane[4]) / plane[1])

  if this.position[1] < x + this.bounding_sphere_radius then
    this.position[1] = x + this.bounding_sphere_radius
  end

  plane = camera:get_frustum_plane(2)
  y     = -(((plane[3] * this.position[3]) + plane[4]) / plane[2])

  if this.position[2] < y + this.bounding_sphere_radius then
    this.position[2] = y + this.bounding_sphere_radius
  end

  plane = camera:get_frustum_plane(3)
  y     = -(((plane[3] * this.position[3]) + plane[4]) / plane[2])

  if this.position[2] > y - this.bounding_sphere_radius then
    this.position[2] = y - this.bounding_sphere_radius
  end
end

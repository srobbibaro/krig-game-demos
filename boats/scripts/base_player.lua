control_pressed = {
  up    = 0,
  down  = 0,
  left  = 0,
  right = 0
}

function update(this, controls, key_state)
  this:orient_on_terrain(0.0, 0.0, 0.0)

  this   = this:load()
  camera = krig.get_camera():load()

  this.velocity = camera.velocity

  for k, v in pairs(controls) do
    if key_state.key_pressed(v) == 1 then
      control_pressed[k] = 1
    end
    if key_state.key_released(v) == 1 then
      control_pressed[k] = 0
    end
  end

  if control_pressed["up"]    == 1 then this.velocity[3] = this.velocity[3] - 25 end
  if control_pressed["down"]  == 1 then this.velocity[3] = this.velocity[3] + 25 end
  if control_pressed["left"]  == 1 then this.velocity[1] = this.velocity[1] - 25 end
  if control_pressed["right"] == 1 then this.velocity[1] = this.velocity[1] + 25 end

  restrict_to_view(this, camera)

  this:save()
end

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

  if this.position[3] > 0 then
    this.position[3] = 0
  end

  if this.position[3] < -140 then
    this.position[3] = -140
  end
end

function on_collision(this,temp)
  temp = temp:load()
  if temp.type_id == 100 then
    this:orient_on_terrain(0.0, 0.0, 0.0)
  end
end

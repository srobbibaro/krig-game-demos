dofile('./scripts/base_enemy.lua')
dofile('./scripts/base_shooting_object.lua')

-- Configuration
x_min = 0
x_max = 0
y_min = 0.0
y_max = 0.0

shot_timer = 0.0
score      = 5000

-- Overridden Engine Callbacks
function on_load(this)
  setModel(this, "boss.mdl")
  setRotation(this, 0.0, 0.0, 0.0)
  setScale(this, 20.0, 20.0, 4.0)

  math.randomseed(os.time())
  set_window()
  speed = calc_speed()
  setVelocity(this, -speed, 0.0, 0.0)

  setTypeId(this, 1)
  life = 40

  setupShots(this, './scripts/boss_shot.lua', 0.95)
end

function on_update(this, elapsedTime)
  update_shots(elapsedTime)

  this_position = getPosition(this)
  this_velocity = getVelocity(this)

  if this_velocity[1] > 0.0 then
    if this_position[1] > x_max then
      speed = calc_speed()
      setVelocity(this, 0.0, speed, 0.0)
    end
  elseif this_velocity[1] < 0.0 then
    if this_position[1] < x_min then
      speed = calc_speed()
      setVelocity(this, 0.0, speed, 0.0)
    end
  elseif this_velocity[2] > 0.0 then
    if this_position[2] > y_max then
      speed = calc_speed()
      setVelocity(this, speed, 0.0, 0.0)
    end
  elseif this_velocity[2] < 0.0 then
    if this_position[2] < y_min then
      speed = calc_speed()
      setVelocity(this, speed, 0.0, 0.0)
      set_window()
    end
  end

  plr = getPlayer()
  plr_pos = getPosition(plr)
  in_view = getInView(this)

  if in_view == 1 then
    radius = getBoundingSphereRadius(this) - 1.25
    attemptShots(this, 2, {radius, radius}, {radius, -radius})
  end
end

function on_collision(this, temp)
  handle_collision(this, temp)
end

function on_unload(this) end

-- Helper functions
function set_window()
  camera = getCamera()
  camera_position = getPosition(camera)
  x_min = camera_position[1] - math.random(50)
  x_max = camera_position[1] + math.random(50)
  y_min = camera_position[2] + math.random(10) + 5
  y_max = camera_position[2] + math.random(50)
end

function calc_speed()
  speed = math.random(40)
  speed = 70.0 - speed

  if math.random(2) == 1 then
    speed = speed * -1
  end

  return speed
end

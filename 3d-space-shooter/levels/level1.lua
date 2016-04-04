dofile("./levels/level_lib.lua")

-- Configuration
X_START_CAMERA = 160.0
Z_START_CAMERA = -20.0
X_START_PLAYER = X_START_CAMERA

boss     = nil
bossLife = 0

-- Overriden Engine Callbacks
function on_load(terrain)
  krig.level.set_sky_box(
    0.2, 0.5, 0.8,
    0.7, 0.2, 0.5,
    0.6, 0.4, 0.7
  )

  krig.level.set_light_direction(0.25, 0.25, 0.5)

  krig.level.set_terrain(terrain, "./terrains/level1.txt")
  terrain.collision_detection_enabled = false
  terrain:save()

  player = krig.get_player()
  player:set_script("./scripts/player.lua")
  player.position = {X_START_PLAYER, 20.0, Z_START_CAMERA - 20.0}
  player:save()

  camera = krig.get_camera()
  camera:set_script("./scripts/camera.lua")
  camera.position = {X_START_CAMERA, 20.0, Z_START_CAMERA}
  camera:save()

  for i=1,25 do
    obj = krig.level.add_object("./scripts/building.lua")
    obj.position = {130.0, 10.0, -(i * 70) - 250.0}
    obj.scale    = {10.0, 20.0, 10.0}
    obj:save()

    obj = krig.level.add_object("./scripts/building.lua")
    obj.position = {190.0, 10.0, -(i * 70) - 250.0}
    obj.scale    = {10.0, 20.0, 10.0}
    obj:save()
  end

  for i=1,40 do
    obj = krig.level.add_object("./scripts/enemy_ship.lua")
    obj.position = {(math.random(20) + 150), (15 + math.random(10.0)), -(math.random(200) * 10) - 200.0}
    obj.scale    = {4.0, 4.0, 4.0}
    obj.rotation = krig.rotation.from_euler({0.0,  0.0, 0.0})
    obj:save()
  end

  boss = krig.level.add_object("./scripts/boss.lua")
  boss.position = {160.0, 20.0, -2450.0}
  boss:save()

  camera:add_particle_system(1)
end

function on_draw()
  player = krig.get_player():load()

  for i = 1, 4 do
    gl.PushMatrix()
    gl.Translate(
      player.position[1] + (player.direction[1] * 20.0 * i),
      player.position[2] + (player.direction[2] * 20.0 * i),
      player.position[3] + (player.direction[3] * 20.0 * i)
    )
    gl.Color(0.0, 0.4, 0.7)
    gl.Begin("LINES")
    gl.Vertex(-1.0, -1.0, -1.0)
    gl.Vertex(1.0, -1.0, -1.0)

    gl.Vertex(-1.0, 1.0, -1.0)
    gl.Vertex(1.0, 1.0, -1.0)

    gl.Vertex(-1.0, -1.0, -1.0)
    gl.Vertex(-1.0, 1.0, -1.0)

    gl.Vertex(1.0, -1.0, -1.0)
    gl.Vertex(1.0, 1.0, -1.0)
    gl.End()
    gl.PopMatrix()
  end
end

function on_draw_screen(terrain, elapsedTime)
  bossLife = 0
  if boss ~= nil then bossLife = krig.get_script_value(boss, "life") end
  if bossLife == 0 then boss = nil end

  display_hud(bossLife)
end

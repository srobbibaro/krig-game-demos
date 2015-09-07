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

  krig.level.set_terrain(terrain, "./terrains/level.txt")
  krig.object.disable_collision_detection(terrain)

  player = krig.get_player()
  krig.object.set_script(player, "./scripts/player.lua")
  krig.object.set_position(player, X_START_PLAYER, 20.0, Z_START_CAMERA - 20.0)

  camera = krig.get_camera()
  krig.object.set_script(camera, "./scripts/camera.lua")
  krig.object.set_position(camera, X_START_CAMERA, 20.0, Z_START_CAMERA)

  for i=1,25 do
    obj = krig.level.add_object("./scripts/building.lua")
    krig.object.set_position(obj, 130.0, 10.0, -(i * 70) - 250.0)
    krig.object.set_scale(obj, 10.0, 20.0, 10.0)

    obj = krig.level.add_object("./scripts/building.lua")
    krig.object.set_position(obj, 190.0, 10.0, -(i * 70) - 250.0)
    krig.object.set_scale(obj, 10.0, 20.0, 10.0)
  end

  for i=1,40 do
    obj = krig.level.add_object("./scripts/enemy_ship.lua")
    krig.object.set_position(obj, (math.random(20) + 150), (15 + math.random(10.0)), -(math.random(200) * 10) - 200.0)
    krig.object.set_scale(obj, 4.0, 4.0, 4.0)
    krig.object.set_rotation(obj, 0.0,  0.0, 0.0)
  end

  boss = krig.level.add_object("./scripts/boss.lua")
  krig.object.set_position(boss, 160.0, 20.0, -2450.0)

  krig.object.add_particle_system(camera, 1)
end

function on_draw()
  player = krig.get_player()
  plr_pos = krig.object.get_position(player)
  plr_dir = krig.object.get_direction(player)

  for i = 1, 4 do
    gl.PushMatrix()
    gl.Translate(
      plr_pos[1] + (plr_dir[1] * 20.0 * i),
      plr_pos[2] + (plr_dir[2] * 20.0 * i),
      plr_pos[3] + (plr_dir[3] * 20.0 * i)
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

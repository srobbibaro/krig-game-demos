dofile("./levels/level_lib.lua")

-- Configuration
X_START_CAMERA = 160.0
Z_START_CAMERA = -20.0
X_START_PLAYER = X_START_CAMERA

boss     = nil
bossLife = 0
next_asteroid = 0.0

-- Overriden Engine Callbacks
function on_load(terrain)
  krig.level.set_sky_box(
    0.0, 0.0, 0.0,
    0.0, 0.0, 0.2,
    0.3, 0.0, 0.0
  )

  krig.level.set_light_direction(0.25, 0.25, 0.5)

  --player = krig.get_player()
  --player:set_script("./scripts/player.lua")
  --player.position = {X_START_PLAYER, 20.0, Z_START_CAMERA - 20.0}
  --player:save()

  camera = krig.get_camera()
  camera:set_script("./scripts/camera.lua")
  camera.position = {X_START_CAMERA, 20.0, Z_START_CAMERA}
  camera:save()

  obj = krig.level.add_sprite("./scripts/sprite.lua")
  obj.position = {130, 20, -200}
  obj.scale = {10, 10, 10}
  obj:save()

  asteroid_setup = {
    { position = {130, 20, -200}, scale = {20.0, 20.0, 20.0} },
    { position = {180, 10, -220}, scale = {20.0, 25.0, 20.0} },
    { position = {240, 20, -240}, scale = {25.0, 25.0, 20.0} },
    { position = {110, 0, -260},  scale = {15.0, 25.0, 20.0} },
    { position = {140, 0, -280},  scale = {15.0, 15.0, 20.0} },
    { position = {190, 5, -310},  scale = {20.0, 20.0, 20.0} }
  }

  --for i = 1, #asteroid_setup do
  --  krig.level.add_object("./scripts/asteroid.lua", {
  --    position = asteroid_setup[i].position,
  --    scale    = asteroid_setup[i].scale
  --  })
  --end

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

function on_update(terrain, elapsedTime)
  player = krig.get_player():load()

  if player.position[3] < -300 and player.position[3] > -1000 then
    next_asteroid   = next_asteroid - elapsedTime

    if next_asteroid <= 0.0 then
      krig.level.add_object("./scripts/asteroid.lua", {
        rotation = krig.rotation.from_euler({math.random(3), math.random(3), math.random(3)}),
        velocity = {0.0, 0.0, 36.0},
        scale    = {6, 6, 6},
        position = {50 + math.random(250), -10 + math.random(40), player.position[3] - 300.0}
      })
      next_asteroid = 0.1
    end
  end
end

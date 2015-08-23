dofile("./levels/level_lib.lua")

-- Configuration
X_START_CAMERA = 160.0
Z_START_CAMERA = -20.0
X_START_PLAYER = X_START_CAMERA

boss     = nil
bossLife = 0

-- Overriden Engine Callbacks
function on_load(terrain)
  setSkyBox(
    0.2, 0.5, 0.8,
    0.7, 0.2, 0.5,
    0.6, 0.4, 0.7
  )

  setLightDirection(0.25, 0.25, 0.5)

  setTerrain(terrain, "./terrains/level.txt")
  disableCollisionDetection(terrain)

  player = getPlayer()
  setScript(player, "./scripts/player.lua")
  setPosition(player, X_START_PLAYER, 20.0, Z_START_CAMERA - 20.0)

  camera = getCamera()
  setScript(camera, "./scripts/camera.lua")
  setPosition(camera, X_START_CAMERA, 20.0, Z_START_CAMERA)

  for i=1,25 do
    obj = addObject("./scripts/building.lua")
    setPosition(obj, 130.0, 10.0, -(i * 70) - 250.0)
    setScale(obj, 10.0, 20.0, 10.0)

    obj = addObject("./scripts/building.lua")
    setPosition(obj, 190.0, 10.0, -(i * 70) - 250.0)
    setScale(obj, 10.0, 20.0, 10.0)
  end

  for i=1,40 do
    obj = addObject("./scripts/enemy_ship.lua")
    setPosition(obj, (math.random(20) + 150), (15 + math.random(10.0)), -(math.random(200) * 10) - 200.0)
    setScale(obj, 4.0, 4.0, 4.0)
    setRotation(obj, 0.0,  0.0, 0.0)
  end

  boss = addObject("./scripts/boss.lua")
  setPosition(boss, 160.0, 20.0, -2450.0)

  addParticleSystem(camera, 1)
end

function on_draw()
  player = getPlayer()
  plr_pos = getPosition(player)
  plr_dir = getDirection(player)

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
  if boss ~= nil then bossLife = getScriptValue(boss, "life") end
  if bossLife == 0 then boss = nil end

  display_hud(bossLife)
end

function on_update(this) end
function on_unload() end

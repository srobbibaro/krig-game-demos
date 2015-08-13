-- Configuration
x_start_camera  = 110.0
player_position = {
  {x_start_camera - 10.0, 20.0, -15.0},
  {x_start_camera - 10.0, 20.0, -105.0}
}

-- Overridden Engine Callbacks
function on_load(terrain)
  setSkyBox(
    0.8, 0.2, 0.5,
    0.4, 0.4, 0.6,
    0.7, 1.0, 0.2
  )
  setLightDirection(0.25, 0.25, 0.5)
  setTerrain(terrain, "./terrains/level.txt")

  setupPlayers(terrain)

  camera = getCamera()
  setScript(camera, "./scripts/camera1.lua")
  setPosition(camera, x_start_camera, 15.0, 35.0)
end

function on_draw_screen() end
function on_draw() end
function on_update() end

-- Helper Functions
function setupPlayers(terrain)
  for i = 1, #player_position do
    player = addObject(terrain, string.format("./scripts/player%d.lua", i))
    setPositionv(player, player_position[i])
  end
end

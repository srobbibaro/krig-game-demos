-- Configuration
x_start_camera  = 110.0
player_position = {
  {x_start_camera - 10.0, 20.0, -15.0},
  {x_start_camera - 10.0, 20.0, -105.0}
}

-- Overridden Engine Callbacks
function on_load(terrain)
  krig.level.set_sky_box(
    0.8, 0.2, 0.5,
    0.4, 0.4, 0.6,
    0.7, 1.0, 0.2
  )
  krig.level.set_light_direction(0.25, 0.25, 0.5)
  krig.level.set_terrain(terrain, "./terrains/level.txt")

  setupPlayers(terrain)

  camera = krig.get_camera()
  camera:set_script("./scripts/camera1.lua")
  camera.position = {x_start_camera, 15.0, 35.0}
  camera:save()
end

-- Helper Functions
function setupPlayers()
  for i = 1, #player_position do
    player = krig.level.add_object(string.format("./scripts/player%d.lua", i))
    player.position = krig.vector.copy(player_position[i])
    player:save()
  end
end

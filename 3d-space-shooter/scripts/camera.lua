-- Configuration
MAX_Z   = -2350.0
stopped = 0

-- Overridden Engine Callbacks
function on_load(this)
  krig.object.set_velocity(this, 0.0, 0.0, -20.0)
end

function on_update(this, elapsedTime)
  this_position = krig.object.get_position(this)
  if stopped == 0 then
    if this_position[3] <= MAX_Z then
      stopped = 1
      krig.object.set_velocity(this, 0.0, 0.0, 0.0)
      player = krig.get_player()
      player_velocity = krig.object.get_velocity(player)
      krig.object.set_velocity(
        player,
        player_velocity[1],
        player_velocity[2],
        player_velocity[3] + 20.0
      )
    end
  end
end

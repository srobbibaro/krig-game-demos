-- Configuration
MAX_Z   = -2350.0
stopped = 0

-- Overridden Engine Callbacks
function on_load(this)
  setVelocity(this, 0.0, 0.0, -20.0)
end

function on_update(this, elapsedTime)
  this_position = getPosition(this)
  if stopped == 0 then
    if this_position[3] <= MAX_Z then
      stopped = 1
      setVelocity(this, 0.0, 0.0, 0.0)
      player = getPlayer()
      player_velocity = getVelocity(player)
      setVelocity(
        player,
        player_velocity[1],
        player_velocity[2],
        player_velocity[3] + 20.0
      )
    end
  end
end

function on_unload(this) end
function on_collision(this, temp) end

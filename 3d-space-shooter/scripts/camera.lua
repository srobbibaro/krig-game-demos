-- Configuration
MAX_Z   = -2350.0
stopped = 0

-- Overridden Engine Callbacks
function on_load(this)
  this.velocity = {0.0, 0.0, -20.0}
  this:save()
end

function on_update(this, elapsedTime)
  this = this:load()
  if stopped == 0 then
    if this.position[3] <= MAX_Z then
      stopped = 1
      this.velocity = {0.0, 0.0, 0.0}
      this:save()

      player = krig.get_player():load()
      player.velocity = {
        player.velocity[1],
        player.velocity[2],
        player.velocity[3] + 20.0
      }
      player:save()
    end
  end
end

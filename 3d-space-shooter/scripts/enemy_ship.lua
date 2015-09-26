dofile('./scripts/base_enemy.lua')
dofile('./scripts/base_shooting_object.lua')

-- Overridden Engine Callbacks
function on_load(this)
  this:set_model("enemy.mdl")
  this.scale    = {2.0, 2.0, 2.0}
  this.rotation = krig.rotation.from_euler({0.0, -1.57, 0.0})
  this.type_id  = 1
  this:save()

  setupShots(this, "./scripts/enemy_shot.lua", 0.5)

  score = 100
end

function on_update(this, elapsedTime)
  update_shots(elapsedTime)

  plr = krig.get_player():load()
  this = this:load()

  if plr.position[2] < (this.position[2] + .5) and
     plr.position[2] > (this.position[2] - .5) and
     this.in_view then
    attemptShot(this, this.bounding_sphere_radius)
  end
end

function on_collision(this, temp)
  handle_collision(this, temp)
end

dofile('./scripts/base_enemy.lua')
dofile('./scripts/base_shooting_object.lua')

-- Overridden Engine Callbacks
function on_load(this)
  krig.object.set_model(this, "enemy.mdl")
  krig.object.set_scale(this, 2.0, 2.0, 2.0)
  krig.object.set_rotation(this, 0.0, -1.57, 0.0)
  krig.object.set_type_id(this, 1)

  setupShots(this, "./scripts/enemy_shot.lua", 0.5)

  score = 100
end

function on_update(this, elapsedTime)
  update_shots(elapsedTime)

  plr = krig.get_player()
  this_pos = krig.object.get_position(this)
  plr_pos  = krig.object.get_position(plr)
  in_view  = krig.object.get_in_view(this)

  if plr_pos[2] < (this_pos[2] + .5) and
     plr_pos[2] > (this_pos[2] - .5) and
     in_view == 1 then
    attemptShot(this, krig.object.get_bounding_sphere_radius(this))
  end
end

function on_collision(this, temp)
  handle_collision(this, temp)
end

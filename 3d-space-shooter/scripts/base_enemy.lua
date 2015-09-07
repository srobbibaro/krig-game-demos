-- Configuration
life  = 1
score = 0

-- Overridden Engine Callbacks
function handle_collision(this, temp)
  typeId = krig.object.get_type_id(temp)
  thisTypeId = krig.object.get_type_id(this)

  if typeId == 2 or (typeId == 4 and thisTypeId ~= 4) then
    krig.play_sound(this, "explosion1.wav")
    life = life - 1
    if life <= 0 then
      player = krig.get_player()
      player_score = krig.get_script_value(player, "score") + score
      krig.set_script_value(player, "score", player_score)
      create_score_text(this)

      create_explosion(this)

      krig.level.remove_object(this)
    end
  end
end

function create_explosion(this)
  this_position = krig.object.get_position(this)

  obj = krig.level.add_object("./scripts/explosion.lua")
  krig.object.set_position(obj, this_position)
end

function create_score_text(this)
  camera = krig.get_camera()
  cam_vel = krig.object.get_velocity(camera)
  this_position = krig.object.get_position(this)

  obj = krig.level.add_text("./scripts/camera.lua", score)

  krig.object.set_position(obj, this_position)
  krig.object.set_scale(obj, 0.25, 0.25, 0.0)
  krig.object.set_velocity(obj, cam_vel[1], 2.0, cam_vel[3])
  krig.text.set_fade_rate(obj, -.25)
  krig.text.set_color(obj, 1.0, 1.0, 1.0)
end

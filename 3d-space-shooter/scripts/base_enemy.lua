inspect = require('inspect')
-- Configuration
life  = 1
score = 0

-- Overridden Engine Callbacks
function handle_collision(this, temp)
  temp = temp:load()
  this = this:load()

  if temp.type_id == 2 or (temp.type_id == 4 and this.type_id ~= 4) then
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
  this = this:load()

  obj = krig.level.add_object("./scripts/explosion.lua")
  obj.position = {this.position[1], this.position[2], this.position[3]}
  obj:save()
end

function create_score_text(this)
  camera = krig.get_camera():load()
  this   = this:load()

  obj = krig.level.add_text("./scripts/camera.lua", score)

  obj.position  = krig.vector.copy(this.position)
  obj.scale     = {0.25, 0.25, 0.0}
  obj.velocity  = {camera.velocity[1], 2.0, camera.velocity[3]}

  obj.fade_rate = -.25
  obj.color     = {1.0, 1.0, 1.0, 1.0}
  obj:save()
  obj = obj:load()
  print(inspect(obj))
end

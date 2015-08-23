-- Configuration
life  = 1
score = 0

-- Overridden Engine Callbacks
function handle_collision(this, temp)
  typeId = getTypeId(temp)
  thisTypeId = getTypeId(this)

  if typeId == 2 or (typeId == 4 and thisTypeId ~= 4) then
    playSound(this, "explosion1.wav")
    life = life - 1
    if life <= 0 then
      player = getPlayer()
      player_score = getScriptValue(player, "score") + score
      setScriptValue(player, "score", player_score)
      create_score_text(this)

      create_explosion(this)

      removeObject(this)
    end
  end
end

function create_explosion(this)
  this_position = getPosition(this)

  obj = addObject("./scripts/explosion.lua")
  setPositionv(obj, this_position)
end

function create_score_text(this)
  camera = getCamera()
  cam_vel = getVelocity(camera)
  this_position = getPosition(this)

  obj = addText("./scripts/camera.lua", score)

  setPositionv(obj, this_position)
  setScale(obj, 0.25, 0.25, 0.0)
  setVelocity(obj, cam_vel[1], 2.0, cam_vel[3])
  setFadeRate(obj, -.25)
  setColor(obj, 1.0, 1.0, 1.0)
end

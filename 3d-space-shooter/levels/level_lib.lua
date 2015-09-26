bossDefeated = 0
endTimer     = 10.0
debugEnabled = nil

function display_hud(bossLife)
  player = krig.get_player():load()

  ShipEnergy  = krig.get_script_value(player, "life")
  score       = krig.get_script_value(player, "score")
  EnemyEnergy = bossLife
  EnergyBar   = -0.31 - (0.068 * (10.0 - ShipEnergy))
  BossEnergy  = 0.31 + (0.017 * (40.0 - EnemyEnergy))

  gl.PushMatrix()
  gl.Translate (0.0, 0.0, -2.0)
  gl.Color(1.0, 1.0, 1.0)
  krig.render_text("Lives: " .. krig.get_script_value(player, "lives"), -1.0, 0.7)

  krig.render_text("Score: " .. score, -.2, 0.7)

  krig.render_text("Enemy", 0.85, 0.7)

  gl.Begin("QUADS")
  gl.Color(0.0, 0.3, 0.3)
  gl.Vertex(-0.99, 0.67, 0.001)
  gl.Vertex(-0.99, 0.64, 0.001)
  gl.Color(0.0, 1.0, 1.0)
  gl.Vertex(-0.31, 0.64, 0.001)
  gl.Vertex(-0.31, 0.67, 0.001)

  gl.Color(0.0, 0.0, 0.0)
  gl.Vertex(-0.31, 0.64, 0.002)
  gl.Vertex(-0.31, 0.67, 0.002)
  gl.Vertex(EnergyBar, 0.67, 0.002)
  gl.Vertex(EnergyBar, 0.64, 0.002)

  gl.Color(1.0, 1.0, 0.0)
  gl.Vertex(0.31, 0.67, 0.001)
  gl.Vertex(0.31, 0.64, 0.001)
  gl.Color(0.3, 0.3, 0.0)
  gl.Vertex(0.99, 0.64, 0.001)
  gl.Vertex(0.99, 0.67, 0.001)

  gl.Color(0.0, 0.0, 0.0)
  gl.Vertex(BossEnergy, 0.64, 0.002)
  gl.Vertex(BossEnergy, 0.67, 0.002)
  gl.Vertex(0.31, 0.67, 0.002)
  gl.Vertex(0.31, 0.64, 0.002)
  gl.End()

  gl.PopMatrix()
end

function update_level(timeElapsed, bossLife)
  if bossLife <= 0 then
    if bossDefeated == 0 then
      bossDefeated = 1
    elseif bossDefeated == 1 then
      endTimer = endTimer - timeElapsed
      if endTimer < 0.0 then
        krig.level.set_complete(1)
      end
    end
  end
end

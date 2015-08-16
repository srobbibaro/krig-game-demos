-- Overridden Engine Callbacks
function on_load()
  loadLevel('./levels/level.lua')
  setLevelId(1)
end

function on_update(elapsedTime)
  if engine_testKeyPressed(string.byte("q", 1)) == 1 or
     engine_testKeyPressed(string.byte("Q", 1)) == 1 then
    shutdown()
  end
end

function on_unload() end

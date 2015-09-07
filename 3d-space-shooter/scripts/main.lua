-- Overridden Engine Callbacks
function on_load()
  krig.level.load('./levels/level.lua')
  krig.level.set_id(1)
end

function on_update(elapsedTime)
  if krig.test_key_pressed(string.byte("q", 1)) == 1 or
     krig.test_key_pressed(string.byte("Q", 1)) == 1 then
    krig.shutdown()
  end
end

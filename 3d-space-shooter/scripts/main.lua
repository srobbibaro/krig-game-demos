-- Configuration
levels = {
  "./levels/level2.lua",
  "./levels/level1.lua",
}

levelNum  = 1
numLevels = table.getn(levels)

-- Overridden Engine Callbacks
function on_load()
  krig.level.load(levels[levelNum])
  krig.level.set_id(levelNum)
end

function on_update(elapsedTime)
  if krig.test_key_pressed(string.byte("q", 1)) == 1 or
     krig.test_key_pressed(string.byte("Q", 1)) == 1 then
    krig.shutdown()
  end

  if krig.test_key_pressed(string.byte("p", 1)) == 1 then krig.level.pause() end

  if krig.test_key_pressed(string.byte("L", 1)) == 1 then
    inc_level(1)
    krig.level.load(levels[levelNum])
  end

  if krig.test_key_pressed(string.byte("l", l)) == 1 then
    inc_level(-1)
    krig.level.load(levels[levelNum])
  end

  if krig.test_key_pressed(string.byte("k", 1)) == 1 or
    krig.test_key_pressed(string.byte("K", 1)) == 1 then
    krig.level.load(levels[levelNum])
  end

  if krig.level.get_complete() == 1 then
    inc_level(1)

    krig.level.load(levels[levelNum])
  end
end

function inc_level(inc)
  levelNum = levelNum + inc

  if levelNum > numLevels then
    levelNum = 1
  elseif levelNum < 1 then
    levelNum = numLevels
  end
end

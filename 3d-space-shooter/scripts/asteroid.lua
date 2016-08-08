-- Overridden Engine Callbacks
function on_load(this, options)
  this:set_model("asteroid.mdl")
  this.rotation = krig.rotation.from_euler({0.0, 0.0, 0.0})
  this.scale = {5.0, 5.0, 5.0}

  if options == nil then 
    this:save()
    return 
  end

  if options.position then this.position = options.position end
  if options.rotation then this.rotation = options.rotation end
  if options.velocity then this.velocity = options.velocity end
  if options.scale    then this.scale = options.scale end

  this:save()
end

function on_update(this, elapsedTime)
  this   = this:load()
  camera = krig.get_camera():load()

  is_out_of_view(this, this.position, camera.position)
end

function is_out_of_view(this, this_position, camera_position)
  if this_position[3] > camera_position[3] then
    krig.level.remove_object(this)
  end
end

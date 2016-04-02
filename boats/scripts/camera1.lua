-- Overridden Engine Callbacks
function on_load(this)
  this.velocity = {10.0, 0.0, 0.0}
  this:save()
  this = this:load()
end

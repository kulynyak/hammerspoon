local keyUpDown = function(modifiers, key)
  -- Un-comment & reload config to log each keystroke that we're triggering
  -- log.d('Sending keystroke:', hs.inspect(modifiers, key)
  hs.eventtap.keyStroke(modifiers, key, 0)
end

return {
  keyUpDown = keyUpDown
}
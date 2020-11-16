-- Keep holding Cmd-Q to close apps, so you don't do it accidentally. {{{

-- Replaces apps like CommandQ and SlowQuitApps. This works better if you have
-- luasocket, which has to be installed with Lua 5.3 and luarocks to work with
-- Hammerspoon.

local socket = require('socket')
local pressedQTime = 0

local function pressedQ()
  hs.alert.show('⌘Q')
  if socket then
    pressedQTime = socket.gettime()
  else
    pressedQTime = os.time()
  end
end

local function releasedQ()
  hs.alert.closeAll()
end

local function repeatQ()
  if socket then
    if pressedQTime > 0 and socket.gettime() - pressedQTime > 0.04 then
      pressedQTime = 0
      hs.application.frontmostApplication():kill()
      hs.alert.closeAll()
    end
  else
    if pressedQTime > 0 and os.time() - pressedQTime > 0 then
      pressedQTime = 0
      hs.application.frontmostApplication():kill()
      hs.alert.closeAll()
    end
  end
end


hs.hotkey.bind('cmd', 'Q', pressedQ, releasedQ, repeatQ)
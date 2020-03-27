hs.logger.defaultLogLevel = "error"

local log = hs.logger.new('init.lua', 'debug')
-- inspect = require('inspect')

hyperKey = { 'shift', 'ctrl', 'alt', 'cmd' }

-- hs.hotkey.showHotkeys({ 'cmd', 'alt', 'ctrl' }, 's')
-- Use hyper + ` to reload Hammerspoon config
hs.hotkey.bind(hyperKey, '`', nil, function()
  hs.reload()
end)

keyUpDown = function(modifiers, key)
  -- Un-comment & reload config to log each keystroke that we're triggering
  -- log.d('Sending keystroke:', hs.inspect(modifiers), key)

  hs.eventtap.keyStroke(modifiers, key, 0)
end

-- Subscribe to the necessary events on the given window filter such that the
-- given hotkey is enabled for windows that match the window filter and disabled
-- for windows that don't match the window filter.
--
-- windowFilter - An hs.window.filter object describing the windows for which
--                the hotkey should be enabled.
-- hotkey       - The hs.hotkey object to enable/disable.
--
-- Returns nothing.
enableHotkeyForWindowsMatchingFilter = function(windowFilter, hotkey)
  windowFilter:subscribe(hs.window.filter.windowFocused, function()
    hotkey:enable()
  end)

  windowFilter:subscribe(hs.window.filter.windowUnfocused, function()
    hotkey:disable()
  end)
end

require('delete-words')
require('hyper')
require('windows')
require('slowq')
require('spoons')
require('kbl')

-- Instant is better than animated {{{
hs.window.animationDuration = 0
hs.hints.style = 'vimperator'

-- Window shadows off
hs.window.setShadows(false)

local coc = { 'control', 'option', 'command' }

-- Lockscreen - Ctrl+Opt+Cmd+\ {{{
hs.hotkey.bind(coc, '\\', function()
  hs.caffeinate.lockScreen()
end)
-- }}}

-- Hide all windows - Ctrl-Opt-Cmd-Y {{{
hs.hotkey.bind(coc, 'y', nil, function()
-- loop over all running applications
-- hide if not hidden
-- except for Finder, for that, just close visible windows
-- the 'Desktop' window will remain open
  local running = hs.application.runningApplications()
  for i, app in ipairs(running) do
    if app:isHidden() == false then
      if app:name() ~= 'Finder' then
        app:hide()
      else
        for i, win in ipairs(app:visibleWindows()) do
          win:close()
        end
      end
    end
  end
end)
-- }}}

-- -- Invoke hints - Ctrl-Opt-Cmd-O {{{
-- hs.hotkey.bind( coc, "o", nil, function() hs.hints.windowHints() end )
-- -- }}}

-- -- Vim-like window navigation - Ctrl-Opt-Cmd-{hljk} {{{
-- hs.hotkey.bind( coc, "h", function() if hs.window.focusedWindow() then hs.window.focusedWindow():focusWindowWest() end end )
-- hs.hotkey.bind( coc, "l", function() if hs.window.focusedWindow() then hs.window.focusedWindow():focusWindowEast() end end )
-- hs.hotkey.bind( coc, "j", function() if hs.window.focusedWindow() then hs.window.focusedWindow():focusWindowSouth() end end )
-- hs.hotkey.bind( coc, "k", function() if hs.window.focusedWindow() then hs.window.focusedWindow():focusWindowNorth() end end )
-- -- }}}

-- mute on wake
function muteOnWake(eventType)
  if (eventType == hs.caffeinate.watcher.systemDidWake) then
      local output = hs.audiodevice.defaultOutputDevice()
      output:setMuted(true)
  end
end
caffeinateWatcher = hs.caffeinate.watcher.new(muteOnWake)
caffeinateWatcher:start()

hs.keycodes.setLayout("U.S.")

local kbdTable = { en = "U.S.", uk = "Ukrainian+"}

local function setKbd(src)
  local keyL = kbdTable[src]
  -- local srcId = "com.apple.keylayout." .. keyL
  -- hs.keycodes.currentSourceID(srcId)
  -- log.d("kbd: " .. srcId)
  hs.keycodes.setLayout(keyL)
end

local key2App = require('hyper-apps')

hs.window.filter.default:subscribe(hs.window.filter.windowFocused, function(window, appName)
  for key, app in pairs(key2App) do
    local path = app[2]
    local im = app[3]
    -- log.d("current: " .. path .. ",path: " .. window:application():path())
    if window:application():path() == path then
      log.d("found: " .. path .. ", im: " .. im)
      if im then
        -- hs.timer.doAfter(0.1, function() setKbd(im) end)
        setKbd(im)
      end
      break
    end
  end
end)

-- set up your windowfilter {{{
  local switcher = hs.window.switcher.new() -- default windowfilter: only visible windows, all Spaces
  switcher.ui.fontName = 'Monaco'
  switcher.ui.textSize = 14
  switcher.ui.showTitles = true
  switcher.ui.showThumbnails = false
  switcher.ui.showSelectedThumbnail = false
  switcher.ui.showSelectedTitle = false

  -- bind to hotkeys; WARNING: at least one modifier key is required!
  hs.hotkey.bind('alt', 'tab', nil, function()
    switcher:next()
  end)

  hs.hotkey.bind('alt-shift', 'tab', nil, function()
    switcher:previous()
  end)
  -- }}}

require('launch')

hs.notify.new({
  title = 'Hammerspoon',
  informativeText = 'Ready to rock 🤘',
}):send()

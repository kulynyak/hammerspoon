-- local log = hs.logger.new('init.lua', 'debug')
inspect = require('inspect')

hs.hotkey.showHotkeys({ 'cmd', 'alt', 'ctrl' }, 's')
-- Use hyper + ` to reload Hammerspoon config
hs.hotkey.bind({ 'shift', 'ctrl', 'alt', 'cmd' }, '`', nil, function()
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

-- require('control-escape')
require('delete-words')
require('hyper')
-- require('markdown')
-- require('panes')
-- require('super')
require('windows')
require('slowq')
require('spoons')
require('kbl')

-- Instant is better than animated {{{
hs.window.animationDuration = 0
hs.hints.style = 'vimperator'

-- Window shadows off
hs.window.setShadows(false)

-- set up your windowfilter {{{
local switcher = hs.window.switcher.new() -- default windowfilter: only visible windows, all Spaces
switcher.ui.fontName = 'Monaco'
switcher.ui.textSize = 14
switcher.ui.showTitles = false
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

hs.notify.new({
  title = 'Hammerspoon',
  informativeText = 'Ready to rock 🤘',
}):send()

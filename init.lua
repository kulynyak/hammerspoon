hs.logger.defaultLogLevel = "error"
local log = hs.logger.new('init.lua', 'debug')

require('delete-words')
require('windows')
require('slowq')
require('spoons')
require('launch')

local hyperex = require('hyperex')
-- main hyper key space {{{
local hxa = hyperex.new('f18'):sticky('once')
-- :setEmptyHitKey('escape')
-- setup apps
require('apps')(hxa)
-- setup kbl
local kbl = require('kbl')
hxa:bind('0'):to(kbl)
-- setup translation
local wm = hs.webview.windowMasks
local translator = require("PopupTranslateSelection")
translator.popup_style = wm.utility | wm.HUD | wm.titled | wm.closable |
                             wm.resizable
local hyper = {"cmd", "alt", "shift", "ctrl"}
translator:bindHotkeys({
    translate_uk_en = {hyper, "8"},
    translate_en_uk = {hyper, "9"}
})
hxa:bind('8'):to('8', hyper)
hxa:bind('9'):to('9', hyper) 
hxa:bind('/'):to('space', {'cmd'})
-- }}}

-- -- auxilary hyper key r-ALT {{{
-- local hxb = hyperex.new('f18'):sticky('once'):setEmptyHitKey('escape')
-- hxb:mod({'ctrl', 'alt', 'cmd'}):to('atoz')
-- hxb:mod({'ctrl', 'alt', 'cmd'}):to('\\')
-- -- }}}

local coc = {'control', 'option', 'command'}
-- Lockscreen - Ctrl+Opt+Cmd+\ {{{
hs.hotkey.bind(coc, '\\', function() hs.caffeinate.lockScreen() end)
-- }}}

-- Hide all windows - Ctrl-Opt-Cmd-Y {{{
hs.hotkey.bind(coc, 'y', nil, function()
    -- loop over all running applications
    -- hide if not hidden
    -- except for Finder, for that, just close visible windows
    -- the 'Desktop' window will remain open
    running = hs.application.runningApplications()
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

-- Instant is better than animated {{{
hs.window.animationDuration = 0
hs.hints.style = 'vimperator'
-- }}}

-- Window shadows off {{{
hs.window.setShadows(false)
-- }}}

-- mute on wake {{{
function muteOnWake(eventType)
    if (eventType == hs.caffeinate.watcher.systemDidWake) then
        local output = hs.audiodevice.defaultOutputDevice()
        output:setMuted(true)
    end
end
caffeinateWatcher = hs.caffeinate.watcher.new(muteOnWake)
caffeinateWatcher:start()
-- }}}

-- fix layout {{{
hs.keycodes.setLayout("U.S.")
kbdTable = {en = "U.S.", uk = "Ukrainian+"}
function setKbd(src)
    keyL = kbdTable[src]
    hs.keycodes.setLayout(keyL)
end
-- }}}

-- set keyboard for apps on enter {{{
local key2App = require('apps-def')
hs.window.filter.default:subscribe(hs.window.filter.windowFocused,
                                   function(window, appName)
    for key, app in pairs(key2App) do
        local path = app[2]
        local im = app[3]
        -- log.d("current: " .. path .. ",path: " .. window:application():path())
        if window:application():path() == path then
            -- log.d("found: " .. path .. ", im: " .. im)
            if im then
                -- hs.timer.doAfter(0.1, function() setKbd(im) end)
                setKbd(im)
            end
            break
        end
    end
end)
-- }}}

-- -- set up your windowfilter {{{
-- switcher = hs.window.switcher.new() -- default windowfilter: only visible windows, all Spaces
-- switcher.ui.fontName = 'Monaco'
-- switcher.ui.textSize = 15
-- switcher.ui.showTitles = true
-- switcher.ui.showThumbnails = false
-- switcher.ui.showSelectedThumbnail = false
-- switcher.ui.showSelectedTitle = true
-- -- bind to hotkeys; WARNING: at least one modifier key is required!
-- hs.hotkey.bind('alt', 'tab', nil, function() switcher:next() end)
-- hs.hotkey.bind('alt-shift', 'tab', nil, function() switcher:previous() end)
-- -- }}}

-- Use hyper + ` to reload Hammerspoon config {{{
hxa:bind('`'):to(hs.reload)
hs.notify.new({title = 'Hammerspoon', informativeText = 'Ready to rock 🤘'}):send()
-- }}}

-- alt ⌥+F to jump Forward by a word
-- alt ⌥+B to jump Backward by a word
-- alt ⌥+D to delete a word starting from the current cursor position
-- ctrl+W to remove the word backwards from cursor position
-- ctrl+A to jump to start of the line
-- ctrl+E to jump to end of the line
-- ctrl+K to kill the line starting from the cursor position
-- ctrl+Y to paste text from the kill buffer
-- ctrl+F to move forward by a char
-- ctrl+B to move backward by a char
-- -- delete word to right forward
-- hs.hotkey.bind( {"alt"}, "d", function()
--     hs.eventtap.keyStroke({"ctrl", "alt", "shift"}, "f")
--     hs.eventtap.keyStroke({}, "delete")
--   end
-- )
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true

local Install = spoon.SpoonInstall

Install:andUse("Commander")

Install:andUse("HoldToQuit", {start = true})

Install:andUse("Caffeine")
local caffeine = spoon.Caffeine:start()
caffeine.clicked()

Install:andUse("BingDaily")

Install:andUse("RoundedCorners", {start = true})

Install:andUse("TextClipboardHistory", {
    start = true,
    config = {show_in_menubar = true, hist_size = 100, paste_on_select = false},
    hotkeys = {toggle_clipboard = {{"cmd", "shift"}, "v"}}
})

local col = hs.drawing.color.x11
Install:andUse("MenubarFlag", {
    start = true,
    config = {
        colors = {
            ["U.S."] = {},
            ["Ukrainian - PC"] = {col.blue, col.yellow},
            ["Ukrainian"] = {col.blue, col.yellow},
            ["Ukrainian+"] = {col.blue, col.yellow}
        }
    }
})

local chrome = "com.google.Chrome"
local opera = "com.operasoftware.Opera"
local safari = "com.apple.Safari"
local firefox = "org.mozilla.firefox"
local firefoxDev = "org.mozilla.firefoxdeveloperedition"
local vivaldi = "com.vivaldi.Vivaldi"
local brave = "com.brave.Browser"

local defBrowser = vivaldi

local nixBrowser = nil
local devBrowser = nil
local synBrowser = nil
local rewBrowser = nil

local nixBrowserX = chrome
local devBrowserX = chrome
local synBrowserX = chrome
local rewBrowserX = chrome

local fireIf = function(browser)
    return function(url)
        local target = defBrowser
        if hs.application.find(browser) then
            target = browser
        end
        hs.application.launchOrFocusByBundleID(target)
        hs.urlevent.openURLWithBundle(url, target);
    end
end


Install:andUse("URLDispatcher", {
    start = true,
    -- Enable debug logging if you get unexpected behavior
    loglevel = 'error',
    config = {
        url_patterns = {
             -- messingers
            { "msteams:", "com.microsoft.teams" },
            { "zoommtg:", "us.zoom.xos" },
            { "tg:", "ru.keepcoder.Telegram" },
            -- mine
            {".*kulynyak.*", devBrowser, fireIf(devBrowserX)},
            {".*localhost.*", devBrowser, fireIf(devBrowserX)},
            {".*127%.0%.0%.1.*", devBrowser, fireIf(devBrowserX)},
            --
            {"https?://.*skype%.com.*", defBrowser},
            {"https?://.*maps%.google%.com.*", defBrowser},
            --
            -- rew
            {"https?://.*us%.exg7%.exghost%.com.*", rewBrowser, fireIf(rewBrowserX)},
            {"https?://.*office365%.com.*", rewBrowser, fireIf(rewBrowserX)},
            {"https?://.*mail%.rewconsultingservices%.com.*", rewBrowser, fireIf(rewBrowserX)},
            -- nix
            {"https?://.*google%.com", nixBrowser, fireIf(nixBrowserX)},
            {"https?://.*n-ix.*", nixBrowser, fireIf(nixBrowserX)},
            {"https?://.*clockify%.me.*", nixBrowser, fireIf(nixBrowserX)},
            -- syniverse
            {"https?://.*syniverse%.com.*", synBrowser, fireIf(synBrowserX)},
            {"https?://.*appriver%.com.*", synBrowser, fireIf(synBrowserX)},
            {"https?://.*us%.exg7%.exghost%.com.*", synBrowser, fireIf(synBrowserX)},
            {"https?://.*myworkday%.com.*", synBrowser, fireIf(synBrowserX)},
            {"https?://.*windowsazure%.com.*", synBrowser, fireIf(synBrowserX)},
            {"https?://.*fortify%.com.*", synBrowser, fireIf(synBrowserX)},
            {"https?://.*ideaboardz%.com.*", synBrowser, fireIf(synBrowserX)},
        },
        url_redir_decoders = {
            {
                "MS Teams URLs",
                "(https?://teams%.microsoft%.com.*)",
                "msteams:%1",
                true
            },
            {
                "Zoom URLs",
                "https?://.*zoom%.us/j/(%d+)%?pwd=(%w)",
                "zoommtg://zoom.us/join?confno=%1&pwd=%2",
                true
            },
            {
                "Telegram URLs",
                "https?://t.me/(.*)",
                "tg://t.me/%1",
                true
            },
            {
                "Fix broken Preview anchor URLs",
                "%%23",
                "#",
                false,
                "Preview"
            },
        },
        default_handler = defBrowser,
    }
});

spoon.SpoonInstall:asyncUpdateAllRepos()

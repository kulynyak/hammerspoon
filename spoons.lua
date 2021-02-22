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
    config = {show_in_menubar = false, hist_size = 40},
    hotkeys = {toggle_clipboard = {{"cmd", "shift"}, "v"}}
})

-- local col = hs.drawing.color.x11
-- Install:andUse("MenubarFlag", {
--     start = true,
--     config = {
--         colors = {
--             ["U.S."] = {},
--             ["Ukrainian - PC"] = {col.blue, col.yellow},
--             ["Ukrainian"] = {col.blue, col.yellow},
--             ["Ukrainian+"] = {col.blue, col.yellow}
--         }
--     }
-- })

local chrome = "com.google.Chrome"
local opera = "com.operasoftware.Opera"
local safari = "com.apple.Safari"
local firefox = "org.mozilla.firefox"
-- local firefox = "org.mozilla.firefoxdeveloperedition"
local vivaldi = "com.vivaldi.Vivaldi"
local brave = "com.brave.Browser"

-- local dodsBrowser = chrome
local nixBrowser = chrome
local devBrowser = chrome
local synBrowser = chrome
local rewBrowser = chrome
local defBrowser = safari

Install:andUse("URLDispatcher", {
    start = true,
    -- Enable debug logging if you get unexpected behavior
    loglevel = 'debug',
    config = {
        url_patterns = {
             -- messingers
            { "msteams:", "com.microsoft.teams" },
            { "zoommtg:", "us.zoom.xos" },
            { "tg:", "ru.keepcoder.Telegram" },
            -- mine
            {"kulynyak", defBrowser},
            {"localhost", defBrowser},
            {"127%.0%.0%.1", defBrowser},
            --
            {"https?://.*skype%.com", defBrowser},
            --
            -- rew
            {"https?://.*us%.exg7%.exghost%.com", rewBrowser},
            {"https?://.*office365%.com", rewBrowser},
            {"https?://.*mail%.rewconsultingservices%.com", rewBrowser}, -- nix
            {"https?://.*google%.com", nixBrowser},
            {"https?://.*n-ix.*", nixBrowser},
            {"https?://.*%.clockify%.me", nixBrowser},
            -- syniverse
            {"https?://.*syniverse.%com.*", synBrowser},
            {"https?://.*appriver%.com.*", synBrowser},
            {"https?://.*us%.exg7%.exghost%.com", synBrowser},
            {"https?://.*myworkday%.com", synBrowser},
            {"https?://.*windowsazure%.com", synBrowser},
            {"https?://.*fortify%.com", synBrowser},
            {"https?://.*ideaboardz%.com", synBrowser},
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

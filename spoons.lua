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
spoon.SpoonInstall.use_syncinstall = false

local hyper = {"cmd", "alt", "shift", "ctrl"}

local Install = spoon.SpoonInstall

Install:andUse(
  "Caffeine",
  {
    hotkeys = {
      toggle = {hyper, "="}
    }
  }
)

local caffeine = spoon.Caffeine:start()
caffeine.clicked()

Install:andUse("BingDaily")

Install:andUse("RoundedCorners", {start = true})

-- Install:andUse('HeadphoneAutoPause', {
--   start = true,
--   control = {
--     itunes = true,
--     spotify = true,
--     deezer = true,
--     vox = false, -- handled by VOX
--   },
-- })

Install:andUse(
  "TextClipboardHistory",
  {
    start = true,
    config = {
      show_in_menubar = false,
      hist_size = 200
    },
    hotkeys = {
      toggle_clipboard = {{"cmd", "shift"}, "v"}
    }
   }
)

local col = hs.drawing.color.x11
Install:andUse(
  "MenubarFlag",
  {
    start = true,
    config = {
      colors = {
        ["U.S."] = {},
        ["Ukrainian - PC"] = {col.blue, col.yellow},
        ["Ukrainian"] = {col.blue, col.yellow},
        ["Ukrainian+"] = {col.blue, col.yellow},
      }
    }
  }
)

-- local wm = hs.webview.windowMasks
-- Install:andUse('PopupTranslateSelection', {
--   config = {
--     popup_style = wm.utility | wm.HUD | wm.titled | wm.closable | wm.resizable,
--   },
--   hotkeys = {
--     translate_uk_en = { hyper, 'e' },
--     translate_en_uk = { hyper, 'u' },
--   },
-- })

local wm = hs.webview.windowMasks
local translator = require("PopupTranslateSelection")
translator.popup_style = wm.utility | wm.HUD | wm.titled | wm.closable | wm.resizable
translator:bindHotkeys(
  {
    translate_uk_en = {hyper, "e"},
    translate_en_uk = {hyper, "u"}
  }
)

local chrome = "com.google.Chrome"
local opera = "com.operasoftware.Opera"
local safari = "com.apple.Safari"
-- local firefox = "org.mozilla.firefox"
local firefox = "org.mozilla.firefoxdeveloperedition"
local vivaldi = "com.vivaldi.Vivaldi"
local brave = "com.brave.Browser"

-- local dodsBrowser = chrome
local nixBrowser = chrome
local devBrowser = chrome
local synBrowser = chrome
local rewBrowser = chrome
local defBrowser = brave

Install:andUse(
  "URLDispatcher",
  {
    start = true,
    config = {
      url_patterns = {
        -- mine
        {"kulynyak", devBrowser},
        {"localhost", defBrowser},
        {"127%.0%.0%.1", defBrowser},
        --
        {".*%.skype%.com", defBrowser},
        -- -- dods
        -- {".*%.dods%.co%.uk", dodsBrowser},
        -- {".*%.parlicom%.local", dodsBrowser},
        -- {".*%.cloudforge%.com", dodsBrowser},
        -- {".*%.dodssystem%.slack%.com", dodsBrowser},
        -- {".*%.teams%.microsoft%.com", dodsBrowser},
        -- rew
        {".*%.us%.exg7%.exghost%.com", rewBrowser},
        {".*%.office365%.com", rewBrowser},
        {".*%.mail%.rewconsultingservices%.com", rewBrowser},
        -- nix
        {".*%.google%.com", nixBrowser},
        {".*n-ix.*", nixBrowser},
        -- syniverse
        {".*webex.%.*", synBrowser},
        {".*teams.%.*", synBrowser},
        {".*zoom%.*", synBrowser},
        {".*syniverse.%.*", synBrowser},
        {".*%.appriver%.com", synBrowser},
        {".*%.us%.exg7%.exghost%.com", synBrowser},
        {".*%.myworkday%.com", synBrowser},
        {".*%.windowsazure%.com", synBrowser},
        {".*%.fortify%.com", synBrowser},
        {".*%.ideaboardz%.com", synBrowser},
      },
      default_handler = defBrowser
    }
  }
)

spoon.SpoonInstall:asyncUpdateAllRepos()

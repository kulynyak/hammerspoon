-- Default keybindings for launching apps in Hyper Mode
--
-- To launch _your_ most commonly-used  apps via Hyper Mode, create a copy of
-- this file, save it as `hyper-apps.lua`, and edit the table below to configure
-- your preferred shortcuts.

return {
  -- { hotkey, app-path, kbd-layout },                                              -- comment
-- { 'x', '/usr/local/opt/emacs-plus/Emacs.app', 'en' },                              -- "X" for "Emacs"
  { '1', '/Applications/zoom.us.app', 'en' },                                       -- "1" for "Zoom"
  { '2', '/Applications/Postman.app', 'en' },                                       -- "4" for "Postman"
  { '3', '/Applications/Robo 3T.app', 'en' },                                       -- "3" for "Robo 3T"
  { 'a', '/System/Applications/Utilities/Activity Monitor.app', 'en' },             -- "A" for "Activity Monitor"
  { 'b', '/Applications/Brave Browser.app', nil},                                   -- "B" for "Browser"
  { 'c', '/Applications/Visual Studio Code.app', 'en' },                            -- "C for "VSCode"
  { nil, '/Applications/Firefox.app', nil },                                        -- "D" for "Development"
  { 'd', '/Applications/Firefox Developer Edition.app', nil },                      -- "D" for "Development"
  { 'f', '/System/Library/CoreServices/Finder.app', 'en' },                         -- "F" for "Finder"
  { 'g', '/Applications/Google Chrome.app', nil },                                  -- "G" for "Google" HEAD
  { nil, '/Applications/Safari.app', nil },                                         -- "H" for "Safari"
  { 'h', '/Applications/Safari.app', nil },                                         -- "H" for "Safari"
  { 'i', '/Applications/IntelliJ IDEA.app', 'en' },                                 -- "I" for "InwtelliJ IDEA"
  { 'j', '/Applications/Cisco/Cisco AnyConnect Secure Mobility Client.app', 'en' }, -- "J" for "Join VPN"
  { nil, '/Applications/MongoDB Compass.app', 'en' },                               -- "K" for "Compass"
  { 'l', '/Applications/Slack.app', nil },                                          -- "L" for "Slack"
  { 'm', '/System/Applications/Mail.app', 'en' },                                   -- "M" for "Mail"
  { nil, '/Applications/Android Studio.app', 'en' },                                -- "N" for "Android"
  { 'o', '/Applications/Opera.app', nil },                                          -- "O" for "Opera"
  { 'p', '/Applications/MacPass.app', 'en' },                                       -- "P" for "MacPass"
  { nil, '/System/Applications/QuickTime Player.app', nil},                         -- "q" for Quick Time
  { 'r', '/Applications/Viber.app', 'uk' },                                         -- "V" for "Viber"
  { 's', '/Applications/Sourcetree.app', 'en'},                                     -- "S" for "Sourcetree"
  { nil, '/Applications/Skype.app', 'uk' },                                         -- " " for "Skype"
  { nil, '/System/Applications/Utilities/Terminal.app', 'en' },                     -- " " for "Terminal"
  { 'return', '/Applications/Alacritty.app', 'en' },                                -- "↲" for "Alacritty"
  { 't', '/Applications/Telegram.app', nil, },                                      -- "T" for Telegram
  { 'w', '/Applications/WhatsApp.app', 'uk' },                                      -- "W" for "WhatsApp"
  { 'v', '/Applications/Vivaldi.app', nil },                                        -- "X" for "Another Browser"
  { 'z', '/Applications/zoom.us.app', 'en' },                                       -- "Z" for "Zoom US"
  { nil, '/Applications/Microsoft Teams.app', 'en' }                               
}

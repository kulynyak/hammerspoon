-- Default keybindings for launching apps in Hyper Mode
--
-- To launch _your_ most commonly-used  apps via Hyper Mode, create a copy of
-- this file, save it as `hyper-apps.lua`, and edit the table below to configure
-- your preferred shortcuts.

return {
  -- { hotkey, app-path, kbd-layout }, -- comment
  { '1', '/Applications/zoom.us.app', 'en' }, -- "1" for "Zoom"
  { '2', '/Applications/Postman.app', 'en' }, -- "4" for "Postman"
  { '3', '/Applications/Robo 3T.app', 'en' }, -- "3" for "Robo 3T"
  { 'a', '/System/Applications/Utilities/Activity Monitor.app', 'en' }, -- "A" for "Activity Monitor"
  { 'b', '/Applications/Brave Browser.app', 'en'}, -- "B" for "Browser"
  { 'c', '/Applications/Visual Studio Code.app', 'en' }, -- "C for "VSCode"
  { nil, '/Applications/Firefox.app', nil }, -- "D" for "Development"
  { 'd', '/Applications/Firefox Developer Edition.app', 'en' }, -- "D" for "Development"
  { 'f', '/System/Library/CoreServices/Finder.app', 'en' }, -- "F" for "Finder"
  { 'g', '/Applications/Google Chrome.app', 'en' }, -- "g" for "Google"
  { 'h', '/Applications/Safari.app', 'en' }, -- "H" for "Safari"
  { 'i', '/Applications/IntelliJ IDEA.app', 'en' }, -- "I" for "InwtelliJ IDEA"
  { 'j', '/Applications/Cisco/Cisco AnyConnect Secure Mobility Client.app', 'en' }, -- "J" for "Join VPN"
  { 'k', '/Applications/MongoDB Compass.app', 'en' }, -- "K" for "Compass"
  { 'l', '/Applications/Slack.app', nil }, -- "L" for "Slack"
  { nil, '/System/Applications/Mail.app', 'en' }, -- "M" for "Mail"
  { nil, '/Applications/Android Studio.app', 'en' }, -- "N" for "Android"
  { 'o', '/Applications/Opera.app', nil }, -- "O" for "Opera"
  { 'p', '/Applications/MacPass.app', 'en' }, -- "P" for "MacPass"
  { nil, '/System/Applications/QuickTime Player.app', nil}, -- "q" for Quick Time
  { 's', '/Applications/Sourcetree.app', 'en'}, -- "S" for "Sourcetree"
  { nil, '/Applications/Viber.app', 'uk' }, -- "V" for "Viber"
  { nil, '/Applications/Skype.app', 'uk' }, -- "Y" for "Skype"
  -- { 'return', '/System/Applications/Utilities/Terminal.app', 'en' }, -- " " for "Terminal"
  { 'return', '/Applications/Alacritty.app', 'en' }, -- " " for "Terminal"
  { 't', '/Applications/Telegram.app', 'uk', }, -- "T" for Telegram
  { 'w', '/Applications/WhatsApp.app', 'uk' }, -- "W" for "WhatsApp"
  { 'x', '/Applications/Vivaldi.app', nil }, -- "X" for "Another Browser"
  { 'z', '/Applications/zoom.us.app', 'en' }, -- "Z" for "Zoom US"
}
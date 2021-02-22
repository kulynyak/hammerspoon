-- Keybindings for launching apps in Hyper Mode

return {
  -- { hotkey, app-path, kbd-layout },    
  { '1', '/Applications/zoom.us.app', 'en' },                                       -- "1" for "Zoom US"                                          -- comment
  { '2', '/Applications/Postman.app', 'en' },                                       -- "2" for "Postman"
  { '3', '/Applications/Robo 3T.app', 'en' },                                       -- "3" for "Robo 3T"
  { '4', '/Applications/Microsoft Teams.app', 'en' },                               -- "4" for "Microsoft Teams"
  { 'a', '/System/Applications/Utilities/Activity Monitor.app', 'en' },             -- "A" for "Activity Monitor"
  { 'b', '/Applications/Brave Browser.app', nil},                                   -- "B" for "Browser"
  { 'c', '/Applications/Visual Studio Code.app', 'en' },                           -- "C for "VSCode"
  { 'd', '/Applications/Firefox.app', nil },                                        -- "D" for "Development"
  { 'e', '/Applications/Firefox Developer Edition.app', nil },                      -- "E" for "Editionh"
  { 'f', '/System/Library/CoreServices/Finder.app', 'en' },                         -- "F" for "Finder"
  { 'g', '/Applications/Google Chrome.app', nil },                                  -- "G" for "Google"
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
  -- { 'return', '/Applications/Alacritty.app', 'en' },                                -- "↲" for "Alacritty"
  { 'return', '/Applications/kitty.app', 'en' },                                    -- "↲" for "Kitty"
  { 't', '/Applications/Telegram.app', nil, },                                      -- "T" for Telegram
  { 'w', '/Applications/WhatsApp.app', 'uk' },                                      -- "W" for "WhatsApp"
  { 'v', '/Applications/Vivaldi.app', nil },                                        -- "V" for "Another Browser"
  { 'z', '/Applications/Safari.app', nil },                                         -- "Z" for "Safari"
}

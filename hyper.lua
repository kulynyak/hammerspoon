local status, hyperModeAppMappings = pcall(require, 'hyper-apps')

if not status then
  hyperModeAppMappings = require('hyper-apps-defaults')
end
-- hs.application.enableSpotlightsForNameSearches(true)
for i, mapping in ipairs(hyperModeAppMappings) do
  local key = mapping[1]
  local app = mapping[2]
  hs.hotkey.bind({ 'shift', 'ctrl', 'alt', 'cmd' }, key, function()
    if (type(app) == 'string') then
    hs.application.launchOrFocus(app)
      -- hs.application.open(app)
    elseif (type(app) == 'function') then
      app()
    else
      hs.logger.new('hyper'):e('Invalid mapping for Hyper +', key)
    end
  end)
end
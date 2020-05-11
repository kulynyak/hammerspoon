local  hyperModeAppMappings = require('hyper-apps')

-- hs.application.enableSpotlightsForNameSearches(true)
for i, mapping in ipairs(hyperModeAppMappings) do
  local key = mapping[1]
  local app = mapping[2]
  if key then
    hs.hotkey.bind(hyperKey, key, function()
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
end

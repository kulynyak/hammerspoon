local hyperModeAppMappings = require('apps-def')
local log = hs.logger.new('apps.lua', 'debug')

local function apps(hx)
    -- hs.application.enableSpotlightsForNameSearches(true)
    for i, mapping in ipairs(hyperModeAppMappings) do
        local key = mapping[1]
        local app = mapping[2]
        if key then
            hs.hotkey.bind(hx, key, nil, function()
                if (type(app) == 'string') then
                    hs.application.launchOrFocus(app)
                    -- hs.application.open(app)
                elseif (type(app) == 'function') then
                    app()
                else
                    log.e('Invalid mapping for Hyper +', key)
                end
            end)
        end
    end
end

return apps

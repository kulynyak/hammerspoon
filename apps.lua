local hyperModeAppMappings = require('apps-def')

local function apps(hx)
    -- hs.application.enableSpotlightsForNameSearches(true)
    for i, mapping in ipairs(hyperModeAppMappings) do
        local key = mapping[1]
        local app = mapping[2]
        if key then
            hx:bind(key):to(function()
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
end

return apps

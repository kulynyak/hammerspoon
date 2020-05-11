local launch = require('launch-apps')

local function hideIt(app, hide)
    local appObj = hs.application.get(app)
    if (appObj ~= nil and hide) then appObj:hide() end
end

local function launchApps()
    hs.application.enableSpotlightForNameSearches(true)
    for i, mapping in ipairs(launch) do
        local app = mapping[1]
        local bandle = mapping[2]
        local hide = mapping[3]

        if (type(app) == 'string') then
            local appObj = hs.application.get(app)
            if appObj == nil then
                appObj = hs.application.open(bandle, 5, true)
                if appObj ~= nil then
                    hideIt(bandle, hide)
                    for i = 1, 15 do
                        hs.timer.doAfter(i, function()
                            hideIt(bandle, hide)
                        end)
                    end
                end
            end
            hideIt(app, hide)
        end
    end
end

launchApps()

local function hideOnWake(eventType)
    if (eventType == hs.caffeinate.watcher.systemDidWake) then launchApps() end
end

CaffeinateWatcher = hs.caffeinate.watcher.new(hideOnWake)
CaffeinateWatcher:start()

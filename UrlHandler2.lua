local obj = {}
obj.__index = obj

-- Metadata
obj.name = "UrlHandler"
obj.version = "0.1"
obj.author = "Andriy Kulynyak <kulynyak@gmail.com>"
obj.license = "MIT - https://opensource.org/licenses/MIT"

obj.logger = hs.logger.new("UrlHandler")

obj.customBrowsers = {}

obj.widgetWidth = 20

obj._predefinedBrowsers = {
    {id = "com.apple.Safari", name = "Safari", label = "safari"},
    {id = "com.google.Chrome", name = "Chrome", label = "chrome"},
    {id = "com.operasoftware.Opera", name = "Opera", label = "opera"},
    {id = "com.vivaldi.Vivaldi", name = "Vivaldi", label = "vivaldi"},
    {id = "com.brave.Browser", name = "Brave", label = "brave"},
    {id = "org.mozilla.firefox", name = "Firefox", label = "firefox"}, {
        id = "org.mozilla.firefoxdeveloperedition",
        name = "Firefox Dev",
        label = "firefox_dev"
    }
}

obj._label2BundleMap = {}

local function mapByFn(keyFn, valFn, base, override)
    local mix = hs.fnutils.concat(base, override);
    local tmp = {}
    for _, item in ipairs(mix) do tmp[keyFn(item)] = valFn(item) end
    local result = {}
    for _, item in pairs(tmp) do table.insert(result, item) end
    return result
end

local function sortByName(left, right) return left.name < right.name end

local function installedBrowsers(base, overrides)
    local keyFn = function(x) return x.id end
    local valFn = function(x) return x end
    local mixed = mapByFn(keyFn, valFn, base, overrides)
    local result = hs.fnutils.filter(mixed, function(x)
        return hs.application.pathForBundleID(x.id)
    end)
    table.sort(result, sortByName)
    for _, item in pairs(result) do
        item.icon = hs.image.imageFromAppBundle(item.id)
    end
    return result
end

local function mkLabel2BundleMap(browsers)
    local result = {}
    for _, item in ipairs(browsers) do
        if (item.label == nil) then
            obj.logger.ef("Key 'label' have to be defined for item: %s",
                          hs.inspect(item))
        else
            result[item.label] = item
        end
    end
    return result
end

local function browsersByLabels(map, labels)
    local result = {}
    if (labels == nil) then
        for _, item in pairs(map) do table.insert(result, item) end
    else
        for _, label in ipairs(labels) do
            table.insert(result, map[label])
        end
    end
    table.sort(result, sortByName)
    return result
end

local function mkMenuData(browsers, url)
    menuData = {}
    for _, item in ipairs(browsers) do
        table.insert(menuData, {
            text = item.name,
            image = item.icon,
            id = item.id,
            label = item.label,
            url = url
        })
    end
    table.insert(menuData, {text = "Cancel", id = "cancel"})
    return menuData
end

local function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

-- TODO add an althernative chooser widget (like an application List?)
-- actionFn(action)
local function showChooser(map, labels, url, actionFn, widgetWidth)
    local menuData = mkMenuData(browsersByLabels(map, labels), url)
    local selectorobj = hs.chooser.new(actionFn)
    selectorobj:width(widgetWidth)
    selectorobj:choices(menuData)
    selectorobj:refreshChoicesCallback()
    local len = tablelength(menuData) + 1
    if len > 10 then len = 10 end
    selectorobj:rows(len)
    selectorobj:show()
end

function handleSelectBrowserAction(action)
    if (action == nil or action.id == 'cancel' or action.url == nil) then
        return
    end
    hs.application.launchOrFocusByBundleID(action.id)
    hs.timer.doAfter(1, function()
        -- ! TODO reschedule if application still starting 
        -- ! or window is not yet shown
        hs.urlevent.openURLWithBundle(action.url, action.id);
    end)
end

function obj:_showChooser(labels, url)
    showChooser(self._label2BundleMap, labels, url, handleSelectBrowserAction,
                self.widgetWidth)
end

function obj:start()
    local browsers = installedBrowsers(self._predefinedBrowsers,
                                       self.customBrowsers)
    self._label2BundleMap = mkLabel2BundleMap(browsers)

    self:_showChooser({'opera', 'chrome', 'firefox'},
                      "https://github.com/kulynyak")

    -- obj.logger.df("menuData = %s", hs.inspect(menuData))
    return self
end

return obj

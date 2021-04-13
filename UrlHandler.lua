local obj = {}
obj.__index = obj

-- Metadata
obj.name = "UrlHandler"
obj.version = "0.1"
obj.author = "Andriy Kulynyak <kulynyak@gmail.com>"
obj.license = "MIT - https://opensource.org/licenses/MIT"

--- UrlHandler.logger
--- Variable
--- Logger object used within the Spoon. Can be accessed to set the default log level for the messages coming from the Spoon.
obj.logger = hs.logger.new("UrlHandler")

--- UrlHandler._predefinedBrowsers
--- Variable
--  List of predefined browser (so far)
obj._predefinedBrowsers = {
    {id = "com.apple.Safari", name = "Safari"},
    {id = "com.google.Chrome", name = "Chrome"},
    {id = "com.operasoftware.Opera", name = "Opera"},
    {id = "com.vivaldi.Vivaldi", name = "Vivaldi"},
    {id = "com.brave.Browser", name = "Brave"},
    {id = "org.mozilla.firefox", name = "Firefox"},
    {id = "org.mozilla.firefoxdeveloperedition", name = "Firefox Dev"}
}

--- UrlHandler.customBrowsers
--- Variable
--- List of browsers, should be added to the predefined browser list, defaults to {}
--- {
---     {id = "SomeBrowser.bundle.id", name = "Browser Name"},...
---  }
obj.customBrowsers = {}

--- UrlHandler._activeBrowsers
--- Variable
--  List of active browsers
obj._activeBrowsers = {}

--- UrlHandler:_mixWithKnownBrowsers(browsers)
--- Method
--- Mix in given list of browsers to the predefined browsers
---
--- Parameters:
---  * browsers - browsers to be mixed, or used as replacement to the predefined
---
---  {
---     {id = "SomeBrowser.bundle.id", name = "Browser Name"},...
---  }
---
--- Returns:
---  * Updated list of known browsers
function obj:_mixWithKnownBrowsers(browsers)
    local temporaryBrowsers = {}
    -- self.logger.df("Browsers to mix with predefined are: %s", hs.inspect(browsers))
    for _, item in ipairs(obj._predefinedBrowsers) do
        temporaryBrowsers[item.name] = item
    end
    for _, item in ipairs(browsers) do temporaryBrowsers[item.name] = item end
    local result = {}
    for _, item in pairs(temporaryBrowsers) do table.insert(result, item) end
    -- self.logger.df("Mixed browsers are: %s", hs.inspect(result))
    return result
end

--- UrlHandler:_getInstalledBrowsers(browsers)
--- Method
--- Filter given list of browsers to have only installed browsers
---
--- Parameters:
---  * browsers - browsers to be filtered
---
---  {
---     {id = "SomeBrowser.bundle.id", name = "Browser Name"},...
---   }
---
--- Returns:
---  * list of installed browsers with their icons
function obj:_getInstalledBrowsers(browsers)
    local result = {}
    for _, item in ipairs(browsers) do
        if hs.application.pathForBundleID(item.id) then
            item.icon = hs.image.imageFromAppBundle(item.id)
            table.insert(result, item)
        end
    end
    return result
end

--- UrlHandler:_setActiveBrowsers()
--- Method
--- Prepare active browser list
---
--- Parameters:
---  * None
---
--- Returns:
---  * None
function obj:_setActiveBrowsers()
    local mixed = self:_mixWithKnownBrowsers(self.customBrowsers);
    self._activeBrowsers = self:_getInstalledBrowsers(mixed)
end

--- UrlHandler:_populateChooser()
--- Method
--- Fill in the chooser options, including the control options
---
--- Parameters:
---  * browsers - browsers to be shown
---
--- Returns:
---  * None
function obj:_populateChooser(browsers, predicateFn)
    menuData = {}
    for _, item in ipairs(browsers) do
        -- self.logger.df("item = %s", hs.inspect(item))
        if (filterFn and not predicateFn(item)) then goto continue end
        table.insert(menuData,
                     {text = item.name, action = item.id, image = item.icon})
        ::continue::
    end
    table.insert(menuData, {text = "Cancel", action = 'cancel'})
    -- self.logger.df("Returning menuData = %s", hs.inspect(menuData))
    return menuData
end

function obj:_processSelectedItem(url)
    self.logger.df("_processSelectedItem url = %s", hs.inspect(url))
    return function(value)
        if (value.action == 'cancel' or url == nil) then return end
        hs.application.launchOrFocusByBundleID(value.action)
        hs.urlevent.openURLWithBundle(url, value.action);
    end
end

function obj:show(url)
    local selectorobj = hs.chooser.new(hs.fnutils.partial( self:_processSelectedItem(url)))
    selectorobj:choices(hs.fnutils.partial(self._populateChooser, self, self._activeBrowsers))
    selectorobj:refreshChoicesCallback()
    selectorobj:show()
end

--- UrlHandler:start()
--- Method
--- Start handling URLs according to the rules
---
--- Parameters:
---  * None
---
--- Returns:
---  * self
function obj:start()
    self:_setActiveBrowsers()
    return self
end

return obj

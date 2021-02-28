local util = require('util')
local keyUpDown = util.keyUpDown

local obj = {}
obj.__index = obj

-- Metadata
obj.name = "Keychain"
obj.version = "0.1"
obj.author = "Andriy Kulynyak <kulynyak@gmail.com>"
obj.license = "MIT - https://opensource.org/licenses/MIT"
obj.logger = hs.logger.new('keychain')

--- Keychain:read(label, jsonKey)
--- Method
--- Read a password field from a keychain entry label
--- password should be json , e.g.:
--- {"url":"<some url>","username":"<user name>","password":"<password>", ... }
---
--- Parameters:
---  * label - login keychain password
---- * jsonKey - value key name to be read
---
---
--- Returns:
---  * value identified by jsonKey
function obj:read(label, jsonKey)
    local cmd = "/usr/bin/security 2>&1 find-generic-password -wl " .. label ..
                    " | jq -r '." .. jsonKey .. "'"
    local output = hs.execute(cmd, true)
    if (output ~= nil) then return string.gsub(output, '(.*)\n', "%1") end
    return ""
end


--- Keychain:pasteValue(label, jsonKey)
--- Method
--- Paste value identified by label, jsonKey (from the Keychain)
--- into active input control
--- It uses hs.pasterboard to insert value, but it is restored after the
--- operation.
---
--- Parameters:
---  * label - login keychain password
---- * jsonKey - value key name to be read
---
---
--- Returns:
---  * None
function obj:pasteValue(label, jsonKey)
    -- Read value
    local kcValue = self:read(label, jsonKey)
    if kc == "" then
      self.logger.df("Key %s is not found in password json for %s entry", jsonKey,
               label)
        return
    end
    -- Preserve the current contents of the system clipboard
    local originalClipboardContents = hs.pasteboard.getContents()
    -- Paste value into the input
    hs.pasteboard.setContents(kcValue)
    keyUpDown('cmd', 'v')
    -- Allow some time for the command+v keystroke to fire asynchronously before
    -- we restore the original clipboard
    hs.timer.doAfter(0.1, function()
        hs.pasteboard.setContents(originalClipboardContents)
    end)
end


return obj

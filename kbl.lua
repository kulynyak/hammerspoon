local log = hs.logger.new('kbl.lua', 'debug')
local util = require('util')
local keyUpDown = util.keyUpDown

local utf8 = require('lua-utf8')

local function makeTab(from, to)
  local map = {}
  for i = 1, utf8.len(from), 1 do
    local f, t = utf8.sub(from, i, i), utf8.sub(to, i, i)
    map[f] = t
  end
  return map
end

local en_en = "`qwertyuiop[]\\asdfghjkl;'zxcvbnm,./~@#$^&QWERTYUIOP{}|ASDFGHJKL:\"ZXCVBNM<>?"
local uk_pc = "'йцукенгшщзхїґфивапролджєячсмітьбю.ʼ\"№;:?ЙЦУКЕНГШЩЗХЇҐФИВАПРОЛДЖЄЯЧСМІТЬБЮ,"

local en_eu = "qwertyuiop[]asdfghjkl;'\\`zxcvbnm,./QWERTYUIOP{}ASDFGHJKL:\"|~ZXCVBNM<>?"

local uk = "йцукенгшщзхїфівапролджєґ'ячсмитьбю/ЙЦУКЕНГШЩЗХЇФІВАПРОЛДЖЄҐ~ЯЧСМИТЬБЮ?"

local enuk = makeTab(en_eu, uk)
local uken = makeTab(uk, en_eu)

local layouts = {["U.S."] = "Ukrainian+", ["Ukrainian+"] = "U.S."}

local function printTable(t)
  for key, value in pairs(t) do
    print(key, value)
  end
end

local function transform(text)
  -- TODO: try to recognize direction for more precize transformation
  local res1 = ''
  local res2 = ''
  local r1 = 0
  local r2 = 0
  for i = 1, utf8.len(text), 1 do
    local char = utf8.sub(text, i, i)
    local fix1 = enuk[char]
    local fix2 = uken[char]
    if fix1 then
      res1 = res1 .. fix1
      r1 = r1 + 1
    else
      res1 = res1 .. char
    end
    if fix2 then
      res2 = res2 .. fix2
      r2 = r2 + 1
    else
      res2 = res2 .. char
    end
  end
  if r1 > r2 then
    return res1
  else
    return res2
  end
end

-- printTable(enuk)
-- print(transform('кусщкв77'))
-- print(transform('zrfcm кусщк77в \\eqyz &'))
local pasteboard = require('hs.pasteboard')

local function fix()
  -- Preserve the current contents of the system clipboard
  local originalClipboardContents = hs.pasteboard.getContents()
  -- Copy the currently-selected text to the system clipboard
  keyUpDown('cmd', 'c')
  -- Allow some time for the command+c keystroke to fire asynchronously before
  -- we try to read from the clipboard
  hs.timer.doAfter(0.2, function()
    -- Construct the transformed output and paste it over top of the
    -- currently-selected text
    local selectedText = hs.pasteboard.getContents()
    local transformedText = transform(selectedText)
    hs.pasteboard.setContents(transformedText)
    keyUpDown('cmd', 'v')

    -- Allow some time for the command+v keystroke to fire asynchronously before
    -- we restore the original clipboard
    hs.timer.doAfter(0.2, function()
      hs.pasteboard.setContents(originalClipboardContents)
      local curLayout = hs.keycodes.currentLayout()
      hs.keycodes.setLayout(layouts[curLayout])
    end)
  end)
end

return fix



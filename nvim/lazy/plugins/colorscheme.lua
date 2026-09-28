local script_path = debug.getinfo(1, "S").source:sub(2) -- Remove '@' from the path
local script_dir = script_path:match("(.*/)") -- Extract directory

-- Load languages.lua from the same directory
local colour_dir = script_dir .. "colourSchemes/"

local colourScheme = "kanagawa"

local file = colour_dir .. colourScheme .. ".lua"
return dofile(file)

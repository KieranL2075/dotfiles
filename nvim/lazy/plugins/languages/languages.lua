-- languages.lua
local script_path = debug.getinfo(1, "S").source:sub(2) -- Remove '@'
local script_dir = script_path:match("(.*/)") -- Extract directory

-- Load language structure from languageStructure.lua
local Language = dofile(script_dir .. "languageStructure.lua")

-- Use formats based on null-js builtins list at
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
-- instead of Mason
-- Table to store multiple language objects

local languages = {
	Language:new("lua_ls", "stylua"),
	Language:new("clangd", "clang_format"),
	Language:new("jdtls", "checkstyle"),
	Language:new("pyright", "black"),
	-- Language:new("lean-language-server"),
	Language:new("ts_ls", "prettier", "ts-standard"),
}

-- Function to return all language names
local function getAllLanguageNames()
	local names = {}
	for _, lang in ipairs(languages) do
		table.insert(names, lang:getName())
	end
	return names
end

-- Function to return all LSP configs

-- Function to return all formatters and linters combined
local function getAllFormatters()
	local tools_list = {}
	for _, lang in ipairs(languages) do
		if lang:getFormatter() then
			table.insert(tools_list, lang:getFormatter())
		end
	end
	return tools_list
end

local function getAllLinters()
	local list = {}
	for _, lang in ipairs(languages) do
		if lang:getLinter() then
			table.insert(list, lang:getLinter())
		end
	end
	return list
end

local function getAll()
	local replace = true
	local list = {}

	for _, lang in ipairs(languages) do
		table.insert(list, lang:getName())

		local formatter = lang:getFormatter()
		local linter = lang:getLinter()

		-- Ensure formatter and linter are strings before using gsub
		if replace then
			formatter = type(formatter) == "string" and string.gsub(formatter, "_", "-") or formatter
			linter = type(linter) == "string" and string.gsub(linter, "_", "-") or linter
		end

		table.insert(list, formatter)
		table.insert(list, linter)
	end

	return list
end
return {
	getAllLanguageNames = getAllLanguageNames(),
	getAllFormatters = getAllFormatters(),
	getAllLinters = getAllLinters(),
	getAll = getAll(),
}

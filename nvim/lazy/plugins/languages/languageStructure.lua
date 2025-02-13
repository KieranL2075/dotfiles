local Language = {}
Language.__index = Language

function Language:new(name, formatter, linter)
	local lng = setmetatable({}, self)
	lng.name = name
	lng.formatter = formatter or nil
	lng.linter = linter or nil
	return lng
end

-- Getters
function Language:getName()
	return self.name
end

function Language:getFormatter()
	return self.formatter
end

function Language:getLinter()
	return self.linter
end

return Language

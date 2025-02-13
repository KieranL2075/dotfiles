local plugins = {}

-- Get the path to the plugins directory
local plugin_dir = vim.fn.expand("~/dotfiles/nvim/lazy/plugins/")

-- Iterate over all .lua files in the plugins directory
for _, file in ipairs(vim.fn.glob(plugin_dir .. "*.lua", true, true)) do
	local plugin = dofile(file) -- Load the plugin configuration
	if type(plugin) == "table" then
		table.insert(plugins, plugin)
	end
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins)

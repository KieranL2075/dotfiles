local script_path = debug.getinfo(1, "S").source:sub(2) -- Remove '@' from the path
local script_dir = script_path:match("(.*/)") -- Extract directory

-- Load languages.lua from the same directory
local langs = dofile(script_dir .. "languages/languages.lua")

-- print("LSPs to be installed:", vim.inspect(langs.getAllLanguageNames))

return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = langs.getAllLanguageNames, -- Add desired servers here
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			for _, server in ipairs(langs.getAllLanguageNames) do
				if server ~= "lua_ls" then
					if server ~= "pyright" then
						lspconfig[server].setup({
							capabilities = capabilities,
						})
					end
				end
			end
			lspconfig.pyright.setup({
				settings = {
					pyright = {
						reportMissingTypeStubs = false,
						reportMissingImports = false,
						reportGeneralTypeIssues = false,
						reportUnknownMemberType = false,
						reportUnknownVariableType = false,
						reportUnknownParameterType = false,
						reportUnknownArgumentType = false,
					},
					capabilities = capabilities,
				},
			})
			--Lua set up
			lspconfig.lua_ls.setup({

				on_init = function(client)
					local path = client.workspace_folders[1].name
					if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
						return
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								-- Depending on the usage, you might want to add additional paths here.
								-- "${3rd}/luv/library"
								-- "${3rd}/busted/library",
							},
							-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
							-- library = vim.api.nvim_get_runtime_file("", true)
						},
					})
				end,
				settings = {
					Lua = {},
				},
			})

			-- Vim keymaps for lSPs
			vim.keymap.set("n", "<Leader>cd", vim.lsp.buf.definition, { desc = "[d]efinition" })
			vim.keymap.set({ "n" }, "<Leader>ca", vim.lsp.buf.code_action, { desc = "[c]ode [a]ctions" })
			vim.keymap.set("n", "<Leader>r", vim.lsp.buf.rename, { desc = "[r]ename" })
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = langs.getAll,
				integrations = {
					["mason-lspconfig"] = true,
					["mason-null-ls"] = true,
					["mason-nvim-dap"] = true,
				},
			})
			vim.fn.execute("MasonToolsClean", true)
		end,
	},
}

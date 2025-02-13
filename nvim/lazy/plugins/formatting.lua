return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		local script_path = debug.getinfo(1, "S").source:sub(2) -- Remove '@' from the path
		local script_dir = script_path:match("(.*/)") -- Extract directory
		-- Load languages.lua from the same directory
		local langs = dofile(script_dir .. "languages/languages.lua")
		local sourcesFromFile = {}

		for _, formatter in ipairs(langs.getAllFormatters) do
			table.insert(sourcesFromFile, null_ls.builtins.formatting[formatter])
		end

		for _, linter in ipairs(langs.getAllLinters) do
			table.insert(sourcesFromFile, null_ls.builtins.diagnostics[linter])
		end

		null_ls.setup({
			sources = sourcesFromFile,
			on_attach = function(client, bufnr)
				-- Autoformat on save
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		})

		-- Keymap for manual formatting
		vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format current file" })
	end,
}

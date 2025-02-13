return {
	"RRethy/vim-illuminate",
	config = function()
		require("illuminate").configure({
			delay = 50, -- Delay before highlighting (milliseconds)
			filetypes_denylist = { "NvimTree" }, -- Ignore certain filetypes
			providers = { "regex" }, -- Use regex for whole-word highlighting
		})
		-- Move between highlighted occurrences with these keymaps:
		vim.keymap.set("n", "<CR>", require("illuminate").goto_next_reference, { desc = "Next Reference" })
		vim.keymap.set("n", "<S-CR>", require("illuminate").goto_prev_reference, { desc = "Previous Reference" })
		-- Customize highlight group to make it stand out
		vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "DiffChange" }) -- Use 'Visual' highlight
		vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "DiffChange" })
		vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "DiffChange" })
	end,
}

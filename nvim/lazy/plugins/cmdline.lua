return {
	"numToStr/FTerm.nvim",
	config = function()
		require("FTerm").setup({
			dimensions = {
				height = 0.8, -- 80% of the screen height
				width = 0.8, -- 80% of the screen width
				x = 0.5, -- Centered horizontally
				y = 0.5, -- Centered vertically
			},
			border = "rounded", -- Rounded border for the terminal
		})

		local fterm = require("FTerm")
		local terminal = fterm:new({
			ft = "fterm_terminal", -- Filetype for this terminal instance
			cmd = os.getenv("SHELL") or "bash", -- Use the user's default shell or fallback to bash
			cwd = vim.fn.expand("%:p:h"),
			dimensions = {
				height = 0.9,
				width = 0.9,
			},
		})

		-- Keybinding to toggle the terminal in the current working directory
		vim.keymap.set("n", "<Leader>t", function()
			terminal:toggle()
			print(vim.fn.expand("%:p:h"))
		end, { desc = "Toggle terminal in the current working directory" })
	end,
}

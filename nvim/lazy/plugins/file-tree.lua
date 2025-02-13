return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		{ "3rd/image.nvim", opts = {} }, -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				follow_current_file = true, -- Optional: Reveal the current file
				window = {
					mappings = {
						["<leader><CR>"] = "open_vsplit", -- Open in horizontal split
					},
				},
			},
			padding = {
				left = 2, -- Add padding to the left
				right = 2, -- Add padding to the right
				top = 10, -- Add padding to the top
				bottom = 1, -- Add padding to the bottom
			},
			item = {
				margin = 10, -- Add space between items
			},
		})
	end,
}

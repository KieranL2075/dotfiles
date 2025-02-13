return {
	"polirritmico/monokai-nightasty.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("monokai-nightasty").load({
			transparent = false,
			italic_comments = false,
		})
	end,
}

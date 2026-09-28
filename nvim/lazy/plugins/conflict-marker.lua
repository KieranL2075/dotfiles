return {
	{
		"rhysd/conflict-marker.vim",
		config = function()
			-- Disable default conflict marker highlight groups to use Treesitter highlights
			vim.g.conflict_marker_enable_highlight = 1
			vim.g.conflict_marker_highlight_group = ""

			-- Customize conflict marker styling
			vim.cmd([[
        highlight ConflictMarkerBegin guibg=#2f7366
        highlight ConflictMarkerOurs guibg=#2e5049
        highlight ConflictMarkerTheirs guibg=#344f69
        highlight ConflictMarkerEnd guibg=#2f628e
      ]])

			-- Optionally, remove default markers when resolving conflicts
			vim.g.conflict_marker_enable_mappings = 1
		end,
	},
}

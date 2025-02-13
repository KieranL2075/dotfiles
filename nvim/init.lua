-- Run setup.vim for vim setup
--[[
--

local currentFile = debug.getinfo(1,"S").source:sub(2)
local currentDir = currentFile:match("(.*/)")

vim.cmd('source'..currentDir..'setup.vim')
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true
-- Make line numbers default

vim.opt.number = true
vim.opt.relativenumber = true
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"
-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
vim.opt.guifont = "Inter:h14"
-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)
-- Enable break indent
vim.opt.breakindent = true
vim.opt.cindent = true
-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"
-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true

local space = " "
vim.opt.listchars:append({
  tab = "│" .. space,
  multispace = space,
  lead = " ",
  trail = space,
  nbsp = space,
})
-- vim.opt.listchars = { tab = "|", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 12

vim.opt.tabstop = 4     -- Default tab width (in spaces)
vim.opt.shiftwidth = 4  -- Default indentation width (in spaces)
vim.opt.softtabstop = 4 -- Default soft tab stop (in spaces)

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "-", "<cmd>foldclose<CR>", { desc = "Close fold" })
vim.keymap.set("n", "=", "<cmd>foldopen<CR>", { desc = "Open fold" })
vim.keymap.set("n", "_", "zM", { desc = "Close all folds" })
vim.keymap.set("n", "+", "zR", { desc = "Open all folds" })
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "kk", "<Esc>")
vim.keymap.set("n", "H", "Hzz")
vim.keymap.set("n", "L", "Lzz")
vim.keymap.set("n", "Q", "<C-w><C-v>")
vim.keymap.set("n", "<C-x>", "<C-w><C-q>")
vim.keymap.set("n", "<A-k>", "<C-w><C->>")
vim.keymap.set("n", "<A-j>", "<C-w><C-<>")
vim.keymap.set("i", '"', '""<Esc>i')
vim.keymap.set("i", "(", "()<Esc>i")
vim.keymap.set("i", "{", "{}<Esc>i")
vim.keymap.set("i", "[", "[]<Esc>i")
vim.keymap.set("i", "<", "<><Esc>i")
vim.keymap.set("i", "'", "''<Esc>i")
vim.keymap.set("n", "<Leader>g", ":Neogit cwd=%:p:h<CR>")
vim.keymap.set("n", "<M-x>", "gcc", { remap = true, desc = "Toggle comment (gcc) with Alt+X" })
vim.keymap.set("x", "<M-x>", "gc", { remap = true, desc = "Toggle comment on selected lines" })
vim.keymap.set("n", "<Leader>T", function()
  -- Set the VIM_DIR environment variable to the current file's directory
  vim.fn.setenv("VIM_DIR", vim.fn.expand("%:p:h"))
  print(vim.fn.getenv("VIM_DIR"))
  -- Open a terminal and change to the VIM_DIR directory
  vim.cmd("terminal")
  vim.fn.chdir(vim.fn.getenv("VIM_DIR"))
end, { desc = "Open terminal in current file's directory" })

-- Map 'i' to print the current line number and then behave like the normal 'i'
vim.keymap.set("n", "I", function()
  local line_number = vim.fn.line(".")
  local lineContents = vim.fn.getline(line_number)
  local line_prev
  for x = 1, line_number do
    line_prev = vim.fn.getline(line_number - x)
    if line_prev ~= "" then
      break
    end
  end
  local leading_tabs = line_prev:match("^(\t*)") -- Match leading tabs at the start of the line
  -- Simulate pressing 'i' to enter insert mode
  vim.api.nvim_feedkeys("I", "n", true)
  if lineContents == "" then
    for _ = 1, #leading_tabs do
      vim.api.nvim_feedkeys("\t", "n", true) -- Simulate a tab press to move the cursor
    end
  else
    -- Simulate moving the cursor by the number of leading tabs (tab_count)
    local current_cursor = vim.api.nvim_win_get_cursor(0) -- Get current cursor position (row, col)
    -- Move the cursor by the number of leading tabs (tab_count)
    vim.api.nvim_win_set_cursor(0, { current_cursor[1], current_cursor[2] + #leading_tabs })
  end
end)

vim.keymap.set("n", "i", "i")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
vim.keymap.set("n", "<Leader>e", ":Neotree toggle<CR>", {})
-- LSP keybinds

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
  command = "silent !rm -f ~/.local/state/nvim/swap/*.swp",
})

local lazy_dir = vim.fn.expand("~/dotfiles/nvim/lazy/")
-- Lazy.nvim setup
--

-- Using dofile (executes the file)
dofile(vim.fn.expand(lazy_dir .. "lazy.lua"))
-- require(lazy_dir.."lazy.lua")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

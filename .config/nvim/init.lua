-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

-- some vim options
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.g.background = "light"

vim.opt.swapfile = false

vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.cursorline = true

-- Keyboard shortcuts

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<cr>')
vim.keymap.set('n', '<c-j>', ':wincmd j<cr>')
vim.keymap.set('n', '<c-h>', ':wincmd h<cr>')
vim.keymap.set('n', '<c-l>', ':wincmd l<cr>')

-- file system tree
vim.keymap.set("n", "<C-n>", ":Neotree filesystem toggle right<cr>", { desc = "Toggle Neotree" })
vim.keymap.set("n", "<C-b>", ":Neotree buffers toggle right<cr>", { desc = "Toggle Neotree" })

-- Shortcuts for switching buffers
vim.keymap.set('n', '<Tab>', '<cmd>BufferLineCycleNext<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<cr>', { noremap = true, silent = true })

-- Optional: Shortcuts for moving buffers
vim.keymap.set('n', '<Leader>bmn', '<cmd>BufferLineMoveNext<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>bmp', '<cmd>BufferLineMovePrev<cr>', { noremap = true, silent = true })

-- Optional: Shortcut for closing buffers
vim.keymap.set('n', '<Leader>bc', '<cmd>BufferLinePickClose<cr>', { noremap = true, silent = true })

-- telescope
vim.keymap.set("n", "<C-p>", ":Telescope find_files<cr>", {})
vim.keymap.set("n", "<C-space>", ":Telescope live_grep<cr>", {})
-- vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, {})

require("lazy").setup("plugins")

-- color theme
vim.cmd('colorscheme github_dark_default')


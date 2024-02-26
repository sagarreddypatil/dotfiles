vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
vim.opt.termguicolors = true

require("lazy").setup({
  { 'nvim-telescope/telescope.nvim', tag = '0.1.5', dependencies = { 'nvim-lua/plenary.nvim' } },
  'github/copilot.vim',
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
  { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },
  {
    'rmagatti/auto-session',
    config = function() 
      require('auto-session').setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Documents", "~/Downloads", "/"},
      }
    end
  },
  {
    "scalameta/nvim-metals",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = { "scala", "sbt", "java" },
    opts = function()
      local metals_config = require("metals").bare_config()
      -- Change metals version
      metals_config.settings = {
        serverVersion = "0.4.0"
      }
      
      metals_config.on_attach = function(client, bufnr)
        -- your on_attach function
      end

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end
  }
})

-- misc vim settings
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.signcolumn = "yes"

-- do set formatoptions-=cro
vim.cmd('set formatoptions-=cro')

local builtin = require('telescope.builtin')
require("bufferline").setup{}

-- telescope keymaps
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '?', builtin.live_grep, {})

-- bufferline keymaps
for i = 0, 9 do
  vim.keymap.set('n', '<A-'..i..'>', ':BufferLineGoToBuffer '..i..'<CR>', {silent = true})
end

-- alt tab to switch back and forth to previous buffer
vim.keymap.set('n', '<A-Tab>', ':BufferLineCycleNext<CR>', {silent = true})

-- alt left and rigth to move prev and next
vim.keymap.set('n', '<A-Left>', ':BufferLineMovePrev<CR>', {silent = true})
vim.keymap.set('n', '<A-Right>', ':BufferLineMoveNext<CR>', {silent = true})

-- misc keymaps
-- f12 go to definition
vim.keymap.set('n', '<F12>', ':lua vim.lsp.buf.definition()<CR>', {silent = true})

-- <C-w> to close current buffer
vim.keymap.set('n', '<C-w>', ':bd<CR>', {silent = true})

-- set colorscheme
vim.cmd('colorscheme moonfly')


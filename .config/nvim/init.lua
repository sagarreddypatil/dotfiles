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
    'nvim/nvim-lspconfig',
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'onsails/lspkind.nvim',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lua',
      'saadparwaiz1/cmp_luasnip',
      'lukas-reineke/cmp-under-comparator',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'doxnit/cmp-luasnip-choice',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
        }
      })
    end,
    event = 'InsertEnter',
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
  },

})

-- misc vim settings
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.signcolumn = "yes"

-- set colorscheme
vim.cmd('colorscheme moonfly')

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

function ToggleBetweenBuffers()
  vim.cmd('buffer #')
end

-- alt tab to switch back and forth to previous buffer
-- vim.keymap.set('n', '<A-Tab>', ':BufferLineCycleNext<CR>', {silent = true})
vim.keymap.set('n', '<A-Tab>', ':lua ToggleBetweenBuffers()<CR>', {silent = true})


-- alt left and rigth to move prev and next
vim.keymap.set('n', '<A-Left>', ':BufferLineMovePrev<CR>', {silent = true})
vim.keymap.set('n', '<A-Right>', ':BufferLineMoveNext<CR>', {silent = true})

-- <C-w> to close current buffer
vim.keymap.set('n', '<C-w>', ':bd<CR>', {silent = true})

-- misc keymaps
-- f12 go to definition
vim.keymap.set('n', '<F12>', ':lua vim.lsp.buf.definition()<CR>', {silent = true})

-- Setup language servers.
local lspconfig = require('lspconfig')

lspconfig.pyright.setup{}
lspconfig.tsserver.setup{}


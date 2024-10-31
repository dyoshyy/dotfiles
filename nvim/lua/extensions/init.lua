local plugins = {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufNewFile', 'BufReadPre' },
    config = function() require 'extensions.nvim-treesitter' end, 
    build=":TSUpdate",
  },
  {
    'rmehri01/onenord.nvim',
    event = { 'VimEnter' },
    priority = 1000,
    config = function() require 'extensions.onenord' end,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = { 'VimEnter' },
    config = function() require 'extensions.lualine' end,
  },
  {
    'kevinhwang91/nvim-hlslens',
    event = { 'FilterWritePre' },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre' },
  },
  {
    'petertriho/nvim-scrollbar',
    event = { 'BufNewFile', 'BufReadPre' },
  },
  {
    'nvim-telescope/telescope.nvim',
    keys = {
      '<leader>ff', '<leader>fg', '<leader>fb', '<leader>fh'
    },
    tag = '0.1.4',
    config = function() require 'extensions.telescope' end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
  },
  {
   "amitds1997/remote-nvim.nvim",
   version = "*", -- Pin to GitHub releases
   dependencies = {
       "nvim-lua/plenary.nvim", -- For standard functions
       "MunifTanjim/nui.nvim", -- To build the plugin UI
       "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
   },
   config = true,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "neovim/nvim-lspconfig" },
      { "echasnovski/mini.completion", version = false },
    },
    config = function() require 'extensions.lspconfig' end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('extensions.lualine')
    end,
  },
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
}
local opts = {
  checker = {
    enabled = true,
  },
  preformance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      paths = {},
      disabled_plugins = {
        "gzip",
        "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}
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

require("lazy").setup(plugins, opts)

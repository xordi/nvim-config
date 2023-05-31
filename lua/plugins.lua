local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'simrat39/rust-tools.nvim'
  use("hrsh7th/nvim-cmp")
  use({
    -- cmp LSP completion
    "hrsh7th/cmp-nvim-lsp",
    -- cmp Snippet completion
    "hrsh7th/cmp-vsnip",
    -- cmp Path completion
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    after = { "hrsh7th/nvim-cmp" },
    requires = { "hrsh7th/nvim-cmp" },
  })
  use('hrsh7th/vim-vsnip')
  use{
  'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { {'nvim-lua/plenary.nvim'} }
  }
  use "savq/melange"
  use 'shaunsingh/nord.nvim'
  use 'folke/tokyonight.nvim'
  use 'sainnhe/everforest'
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = { 
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  }
  use {
    'romgrk/barbar.nvim', 
    requires = { 'nvim-web-devicons' }
  }
  use 'nvim-treesitter/nvim-treesitter'
  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        signs = {
          error = ""
        }
      }
    end
  }
  use 'christoomey/vim-tmux-navigator'
  use { "windwp/nvim-spectre",
    requires = { "nvim-lua/plenary.nvim" }
  }
  use {'akinsho/git-conflict.nvim', tag = "*", config = function()
      require('git-conflict').setup()
    end
  }

  use {
      "williamboman/mason.nvim",
      run = ":MasonUpdate", -- :MasonUpdate updates registry contents
      config = function()
        require("mason").setup()
      end
  }

  use {
    "williamboman/mason-lspconfig.nvim",
    requires = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig"
    },
    after = {
      "nvim-lspconfig",
      "mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup {
          ensure_installed = { "lua_ls", "rust_analyzer" },
          automatic_installation = true,
      }
    end
  }
  use {
    'echasnovski/mini.bufremove',
    branch = 'stable',
    config = function()
      require("mini.bufremove").setup()
    end
  }
  use {
    'echasnovski/mini.pairs',
    branch = 'stable',
    config = function()
      require("mini.pairs").setup()
    end
  }
  use {
    'ggandor/leap.nvim',
    requires = {
      "tpope/vim-repeat"
    },
    config = function ()
      require("leap").add_default_mappings()
    end
  }
  use {
    "ggandor/flit.nvim",
    requires = {
      "ggandor/leap.nvim",
      "tpope/vim-repeat",
    },
    config = function ()
      require("flit").setup {}
    end
  }
  use {
    "mhartington/formatter.nvim",
    config = function ()
     require("formatter").setup {
       logging = true,
       log_level = vim.log.levels.WARN,
       filetype = {
         sql = {
           function ()
             return {
               exe = "sql-formatter",
               args = {
                 "-l",
                 "postgresql"
               },
               stdin = true,
             }
           end
         },
        yaml = {
           function ()
             return {
               exe = "yamlfmt",
               args = {
                 "-in",
               },
               stdin = true,
             }
           end
        }
       }
     }
    end
  }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

return {
  "simrat39/rust-tools.nvim",
  ft = "rust",
  dependencies = {
    "neovim/nvim-lspconfig"
  },
  opts = function()
    return {
      tools = {
        inlay_hints = {
          show_parameter_hints = false,
          highlight = "ModeMsg",
        },
      },
      server = {
        settings = {
          ["rust-analyzer"] = {
            imports = {
              granularity = {
                group = "module",
              },
              prefix = "crate",
            },
            checkOnSave = {
              command = "clippy"
            },
            cargo = {
              buildScripts = {
                enable = true,
              },
            },
            procMacro = {
              enable = true
            },
          }
        }
      }
    }
  end
}

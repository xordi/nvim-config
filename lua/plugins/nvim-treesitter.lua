return {
  event = { "BufReadPre", "BufNewFile" },
  "nvim-treesitter/nvim-treesitter",
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "rust", "vim", "lua", "elixir", "heex", "eex", "yaml", "json" },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    }
  end
}

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp"
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local nvim_lsp = require("lspconfig")

    -- Elixir LS
    nvim_lsp.elixirls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    nvim_lsp.lua_ls.setup({
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })

    -- Map these keymaps on attaching LSP to a buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local keymap_opts = { buffer = ev.buf }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
        vim.keymap.set("n", "<A-K>", vim.lsp.buf.signature_help, keymap_opts)
        vim.keymap.set("n", "rn", vim.lsp.buf.rename, keymap_opts)
        vim.keymap.set("n", "ga", vim.lsp.buf.code_action, keymap_opts)

        vim.keymap.set("n", "<leader>lc", "I//<Esc>", keymap_opts)
        vim.keymap.set("v", "<leader>c", ":s@^@//@<cr><Esc>", keymap_opts)
      end,
    })

    -- format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.rs", "*.fs", "*.lua" },
      callback = function()
        vim.lsp.buf.format(nil, 200)
      end,
      group = format_sync_grp,
    })

    -- format on save needed for elixir, given that elixir-ls doesn't handle formatting very well...
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = { "*.ex", "*.exs" },
      callback = function()
        vim.fn.system({ "mix", "format" })
      end,
      group = format_sync_grp,
    })
  end
}

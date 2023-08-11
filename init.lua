vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require('plugins')
require('keymaps')

vim.opt.termguicolors = true
vim.cmd([[colorscheme everforest]])

vim.opt.shortmess = vim.opt.shortmess + 'c'

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.autowrite = true
vim.opt.autowriteall = true

-- Neotree config
require('neo-tree').setup({
  filesystem = {
    filtered_items = {
      visible = true,
    },
    follow_current_file = true,
    hijack_netrw_behavior = "disabled",
    close_if_last_window = true,
  }
})

-- LSP config
local nvim_lsp = require'lspconfig'

local on_attach = function(client)
  local keymap_opts = { buffer = buffer }
  -- Code navigation and shortcuts
  vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
  vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, keymap_opts)
  vim.keymap.set("n", "rn", vim.lsp.buf.rename, keymap_opts)
  vim.keymap.set("n", "ga", vim.lsp.buf.code_action, keymap_opts)

  vim.keymap.set("n", "<leader>lc", "I//<Esc>", keymap_opts)
  vim.keymap.set("v", "<leader>c", ":s@^@//@<cr><Esc>", keymap_opts)
end

local rt = require("rust-tools")
rt.setup({
  tools = {
    inlay_hints = {
      show_parameter_hints = false,
      highlight = "ModeMsg",
    },
  },
  server = {
    on_attach = on_attach,
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
})

-- Elixir LSP configuration
local capabilities = require('cmp_nvim_lsp').default_capabilities()
nvim_lsp.elixirls.setup{
    cmd = { "/home/xordi/elixir-ls/language_server.sh" },
    on_attach = on_attach,
    capabilities = capabilities,
}

-- HTML LSP configuration
capabilities.textDocument.completion.completionItem.snippetSupport = true
nvim_lsp.html.setup {
  capabilities = capabilities,
  filetypes = { "html", "heex" }
}

nvim_lsp.lua_ls.setup {
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
}

-- Setup completion
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- Add tab support
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
      -- they way you will only jump inside the snippet region
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },

  -- Installed sources
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
  },
})

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.rs" },
  callback = function()
   vim.lsp.buf.format(nil, 200)
  end,
  group = format_sync_grp,
})

-- format on save when not using LSP
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*" },
  command = "FormatWrite",
  group = FormatAutoGroup,
})


require'nvim-treesitter.configs'.setup {
  ensure_installed = { "rust", "vim", "lua", "elixir", "heex", "eex", "yaml", "json"},
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}

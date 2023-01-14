vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require('plugins')

vim.opt.termguicolors = true
vim.cmd([[colorscheme melange]])

vim.o.completeopt = 'menuone,noinsert,noselect'
vim.opt.shortmess = vim.opt.shortmess + 'c'

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- mappings
vim.g.mapleader = ' '
vim.keymap.set('n', '<Esc>', ':noh<cr>')
vim.keymap.set('n', '<C-s>', ':w<cr>')
vim.keymap.set('n', '<leader>c', ':bd<cr>')
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('i', '<C-s>', '<Esc>:w<cr>')
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('i', 'AA', '<Esc>A')
vim.keymap.set('i', 'II', '<Esc>I')
vim.keymap.set('n', '<leader>r', ':luafile ~/.config/nvim/init.lua<cr>')

-- Telescope mappings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>fd', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>fS', builtin.lsp_workspace_symbols, {})

-- Trouble mappings
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
  {silent = true, noremap = true}
)
-- Neotree config
require('neo-tree').setup({
  filesystem = {
    filtered_items = {
      visible = true,
    },
    follow_current_file = true,
    hijack_netrw_behavior = "open_default",
  }
})

require("toggleterm").setup({
  open_mapping = [[<c-\>]],
  direction = "float",
})

-- LSP config
local nvim_lsp = require'lspconfig'

local on_attach = function(client)
  local keymap_opts = { buffer = buffer }
  -- Code navigation and shortcuts
  vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, keymap_opts)
  vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, keymap_opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
  vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, keymap_opts)
  vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)
  vim.keymap.set("n", "rn", vim.lsp.buf.rename, keymap_opts)
  vim.keymap.set("n", "ga", vim.lsp.buf.code_action, keymap_opts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

  vim.keymap.set("n", "<leader>lc", "I//<Esc>", keymap_opts)
  vim.keymap.set("v", "<leader>c", ":s@^@//@<cr><Esc>", keymap_opts)
end

--local nvim_lsp = require'lspconfig'
--
--nvim_lsp.rust_analyzer.setup({
--    on_attach=on_attach,
--    settings = {
--        ["rust-analyzer"] = {
--          imports = {
--              granularity = {
--                  group = "module",
--              },
--              prefix = "crate",
--          },
--          checkOnSave = {
--            command = "clippy"
--          },
--          cargo = {
--            buildScripts = {
--              enable = true,
--            },
--          },
--          procMacro = {
--            enable = true
--          },
--        }
--    }
--})

local rt = require("rust-tools")

rt.setup({
  tools = {
    inlay_hints = {
      show_parameter_hints = false,
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

-- Setup completion
local cmp = require("cmp")
cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- Add tab support
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
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
    { name = "vsnip" },
    { name = "path" },
    { name = "buffer" },
  },
})

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
   vim.lsp.buf.format(nil, 200)
  end,
  group = format_sync_grp,
})


require'nvim-treesitter.configs'.setup {
  ensure_installed = { "rust", "vim", "lua" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
}


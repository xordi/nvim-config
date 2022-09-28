let mapleader = " "

set number
set relativenumber

set splitright

set tabstop=4
set shiftwidth=2

call plug#begin()


" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Autocompletion framework
Plug 'hrsh7th/nvim-cmp'
" cmp LSP completion
Plug 'hrsh7th/cmp-nvim-lsp'

" cmp Snippet completion
Plug 'hrsh7th/cmp-vsnip'

" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'

" Snippet engine
Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" Nvim tree
Plug 'kyazdani42/nvim-web-devicons' " optional, for file icons
Plug 'kyazdani42/nvim-tree.lua'

Plug 'itchyny/lightline.vim'

call plug#end()

colorscheme tokyonight

autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

lua << EOF

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  disable_netrw = true,
  hijack_netrw = true,
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    side = "left",
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  diagnostics = {
    enable = true,
  },
})
EOF

lua << EOF
local nvim_lsp = require'lspconfig'

local opts = {
    on_attach=on_attach,
    server = {
	tools = {
		autoSetHints = true,
		hover_with_actions = true,
		inlay_hints = {
			show_parameter_hints = false,
			parameter_hints_prefix = "",
			other_hints_prefix = "",
		},
	},
	settings = {
		["rust-analyzer"] = {
			imports = {
			granularity = {
				group = "crate",
			},
			prefix = "crate",
			},
			cargo = {
			buildScripts = {
				enable = true,
			},
			},
			procMacro = {
			enable = true
			},
			checkOnSave = {
			command = "clippy"
			}
		}
	}
    },
}

require('rust-tools').setup(opts)
EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF

map <esc> :noh<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fd <cmd>lua require'telescope.builtin'.diagnostics{}<CR>

nnoremap <leader>ws	<cmd>lua require'telescope.builtin'.lsp_workspace_symbols{}<CR>
nnoremap <leader>ds <cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>

" Code actions
nnoremap <silent> rs	<cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>
vnoremap <silent> ga	<cmd>lua vim.lsp.buf.range_code_action()<CR>

" Goto previous/next diagnostic warning/error
nnoremap <silent> gpe	<cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> gne	<cmd>lua vim.diagnostic.goto_next()<CR>

nnoremap <silent> tt	<cmd>:NvimTreeToggle<CR>
nnoremap <silent> tf	<cmd>:NvimTreeFindFile<CR>

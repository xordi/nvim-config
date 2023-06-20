-- mappings
vim.g.mapleader = ' '
vim.keymap.set('n', '<Esc>', ':noh<cr>')
vim.keymap.set('n', '<C-s>', ':w<cr>')
vim.keymap.set('n', '<leader>y', '"+y', { desc = 'Copy to clipboard'})
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste from clipboard'})
vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy to clipboard'})
vim.keymap.set('v', '<leader>p', '"+p', { desc = 'Paste from clipboard'})
vim.keymap.set('i', '<C-s>', '<Esc>:w<cr>')
vim.keymap.set('i', '<C-s>', '<Esc>:w<cr>')
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('i', 'AA', '<Esc>A')
vim.keymap.set('i', 'II', '<Esc>I')
vim.keymap.set('n', '<leader>r', ':luafile ~/.config/nvim/init.lua<cr>', { desc = 'Reload config'})
vim.keymap.set('n', '<leader>gc', ':GitConflictListQf<cr>', { desc = 'Quick find git conflicts'})

-- Telescope mappings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Find files'})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'LiveGrep find'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers'})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags'})
vim.keymap.set('n', '<leader>fc', builtin.colorscheme, { desc = 'Pick colorscheme'})

vim.keymap.set('n', '<leader>s', builtin.lsp_document_symbols, { desc = 'Find document symbols'})
vim.keymap.set('n', '<leader>S', builtin.lsp_workspace_symbols, { desc = 'Find workspace symbols'})
vim.keymap.set('n', 'gi', builtin.lsp_implementations, { desc = 'Goto implementations'})
vim.keymap.set('n', 'gd', builtin.lsp_definitions, { desc = 'Goto definitions'})
vim.keymap.set('n', 'gD', builtin.lsp_type_definitions, { desc = 'Goto type definitions'})
vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = 'Goto references'})

-- Trouble mappings
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true, desc = 'Toggle trouble'}
)
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
  {silent = true, noremap = true, desc = 'Workspace diagnostics'}
)
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
  {silent = true, noremap = true, desc = 'Document diagnostics'}
)
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
  {silent = true, noremap = true}
)
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
  {silent = true, noremap = true, desc = 'Quickfix list'}
)

-- Spectre mappings
vim.keymap.set("n","<leader>t", "<cmd>lua require('spectre').open()<CR>", { noremap = true, desc = 'Open Spectre'})
vim.keymap.set("n","<leader>tw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", { noremap = true})
vim.keymap.set("v","<leader>t", "<esc>:lua require('spectre').open_visual()<CR>", { noremap = true})
vim.keymap.set("n","<leader>ts", "viw:lua require('spectre').open_file_search()<CR>", { noremap = true})

-- Mini for intelligent buffer removal
vim.keymap.set("n", "<leader>bd", function() require("mini.bufremove").delete(0, false) end, { desc = 'Buffer close'})
vim.keymap.set("n", "<leader>bD", function() require("mini.bufremove").delete(0, true) end, { desc = 'Buffer close (force)'})

-- Barbar mappings
vim.keymap.set("n", "<leader>bl", "<cmd>BufferCloseBuffersLeft<CR>", { noremap = true, desc = 'Close buffers left' })
vim.keymap.set("n", "<leader>br", "<cmd>BufferCloseBuffersRight<CR>", { noremap = true, desc = 'Close buffers right' })
vim.keymap.set("n", "<leader>ba", "<cmd>BufferCloseAllButCurrentOrPinned<CR>", { noremap = true, desc = 'Close all but current or pinned' })
vim.keymap.set("n", "<leader>bb", "<cmd>BufferPick<CR>", { noremap = true, desc = 'Buffer pick' })

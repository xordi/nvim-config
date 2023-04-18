-- mappings
vim.g.mapleader = ' '
vim.keymap.set('n', '<Esc>', ':noh<cr>')
vim.keymap.set('n', '<C-s>', ':w<cr>')
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>p', '"+p')
vim.keymap.set('i', '<C-s>', '<Esc>:w<cr>')
vim.keymap.set('i', '<C-s>', '<Esc>:w<cr>')
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('i', 'AA', '<Esc>A')
vim.keymap.set('i', 'II', '<Esc>I')
vim.keymap.set('n', '<leader>r', ':luafile ~/.config/nvim/init.lua<cr>')
vim.keymap.set('n', '<leader>gc', ':GitConflictListQf<cr>')

-- Telescope mappings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set('n', '<leader>ss', builtin.lsp_document_symbols, {})
vim.keymap.set('n', '<leader>sS', builtin.lsp_workspace_symbols, {})

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

-- Spectre mappings
vim.keymap.set("n","<leader>S", "<cmd>lua require('spectre').open()<CR>", { noremap = true})
vim.keymap.set("n","<leader>sw", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", { noremap = true})
vim.keymap.set("v","<leader>s", "<esc>:lua require('spectre').open_visual()<CR>", { noremap = true})
vim.keymap.set("n","<leader>sp", "viw:lua require('spectre').open_file_search()<CR>", { noremap = true})

-- Mini for intelligent buffer removal
vim.keymap.set("n", "<leader>bd", function() require("mini.bufremove").delete(0, false) end)
vim.keymap.set("n", "<leader>bD", function() require("mini.bufremove").delete(0, true) end)

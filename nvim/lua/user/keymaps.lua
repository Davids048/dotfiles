local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-H>", "<C-w>h", opts)
keymap("n", "<C-J>", "<C-w>j", opts)
keymap("n", "<C-K>", "<C-w>k", opts)
keymap("n", "<C-L>", "<C-w>l", opts)

-- keymap("n", "<leader>e", ":Lex 30<cr>", opts)
keymap("n", "<leader>e", ":NvimTreeFocus<cr>", opts)
keymap("n", "<leader>E", ":NvimTreeClose<cr>", opts)


-- Resize with arrows
keymap("n", "<S-Up>", "<cmd>lua vim.cmd(vim.fn.winnr() == vim.fn.winnr('j') and 'resize +2' or 'resize -2')<CR>", opts)
keymap("n", "<S-Down>", "<cmd>lua vim.cmd(vim.fn.winnr() == vim.fn.winnr('k') and 'resize +2' or 'resize -2')<CR>", opts)
keymap("n", "<S-Left>", "<cmd>lua vim.cmd(vim.fn.winnr() == vim.fn.winnr('l') and 'vertical resize +2' or 'vertical resize -2')<CR>", opts)
keymap("n", "<S-Right>", "<cmd>lua vim.cmd(vim.fn.winnr() == vim.fn.winnr('h') and 'vertical resize +2' or 'vertical resize -2')<CR>", opts)
-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Insert --
-- Press jk fast to enter
-- keymap("i", "jk", "<ESC>", opts) -- I DON'T WANT TO USE THIS.

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts) -- keep the register using the same thing that was yanked first

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)


-- Telescope --
keymap("n", "<leader>ff", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = true }))<cr>", opts)
keymap("n", "<leader>tf", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = true }))<cr>", opts)
keymap("n", "<leader>tg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>tr", "<cmd>Telescope lsp_references<cr>", opts)
keymap("n", "<leader>d", "<cmd>Telescope diagnostics<cr>", opts)
keymap("n", "<leader>td", "<cmd>Telescope lsp_definitions<cr>", opts)

keymap("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers({sort_mru = true, select_current = true})<cr>", opts)
-- Symbols
keymap("n", "<leader>s", ":lua require('telescope.builtin').lsp_document_symbols({sorting_strategy='ascending', show_line = true, symbols = {'function', 'method', 'class', 'module', 'interface', 'struct', 'constructor'}})<cr>", opts)
-- More symbols
keymap("n", "<leader>vs", ":lua require('telescope.builtin').lsp_document_symbols({sorting_strategy='ascending', show_line = true, symbols = {'function', 'method', 'class', 'module', 'interface', 'struct', 'variable', 'constructor', 'field', 'property'}})<cr>", opts)
keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>", opts)


-- RecentDir related keymap
keymap("n", "<leader>red", "<cmd>RecentDir<cr>", opts)

-- ConTeXt
vim.keymap.set("n", "[c", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })


-- Gitsigns
keymap("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", opts)
keymap("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", opts)


-- aerial
keymap("n", "<leader>a", "<cmd>AerialToggle!<CR>", opts)

-- Markdown preview
keymap("n", "<leader>p", "<cmd>MarkdownPreview<cr>", opts)
keymap("n", "<leader>P", "<cmd>MarkdownPreview<cr>", opts)

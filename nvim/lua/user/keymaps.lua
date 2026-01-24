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
-- keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
-- keymap("n", "<leader>tf", "<cmd>Telescope find_files<cr>", opts)
-- keymap("n", "<leader>tg", "<cmd>Telescope live_grep<cr>", opts)
-- keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
-- keymap("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)
-- keymap("n", "<leader>d", "<cmd>Telescope diagnostics bufnr=0<cr>", opts)
-- keymap("n", "<leader>vd", "<cmd>Telescope diagnostics<cr>", opts)
-- keymap("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", opts)
-- keymap("n", "<leader>fd", "<cmd>Telescope lsp_definitions<cr>", opts)
-- keymap("n", "<leader>fi", "<cmd>Telescope lsp_implementations<cr>", opts)

-- keymap("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers({sort_mru = true, select_current = true})<cr>", opts)
-- Symbols
-- keymap("n", "<leader>s", ":lua require('telescope.builtin').lsp_document_symbols({sorting_strategy='ascending', show_line = true, symbols = {'function', 'method', 'class', 'module', 'interface', 'struct', 'constructor'}})<cr>", opts)
-- More symbols
-- keymap("n", "<leader>vs", ":lua require('telescope.builtin').lsp_document_symbols({sorting_strategy='ascending', show_line = true, symbols = {'function', 'method', 'class', 'module', 'interface', 'struct', 'variable', 'constructor', 'field', 'property'}})<cr>", opts)
-- keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>", opts)

-- Fzf --
keymap("n", "<leader>ff", "<cmd>lua require('fzf-lua').files()<cr>", opts)
keymap("n", "<leader>tf", "<cmd>lua require('fzf-lua').files()<cr>", opts)
keymap("n", "<leader>tg", "<cmd>lua require('fzf-lua').live_grep()<cr>", opts)
keymap("n", "<leader>fg", "<cmd>lua require('fzf-lua').live_grep()<cr>", opts)
keymap("n", "<leader>fz", "<cmd>lua require('fzf-lua').blines()<cr>", opts)
keymap("n", "<leader>d", "<cmd>lua require('fzf-lua').diagnostics_document()<cr>", opts)
keymap("n", "<leader>vd", "<cmd>lua require('fzf-lua').diagnostics_workspace()<cr>", opts)
keymap("n", "<leader>fr", "<cmd>lua require('fzf-lua').lsp_references()<cr>", opts)
keymap("n", "<leader>fd", "<cmd>lua require('fzf-lua').lsp_definitions()<cr>", opts)
keymap("n", "<leader>gd", "<cmd>lua require('fzf-lua').lsp_definitions()<cr>", opts)
keymap("n", "<leader>fD", "<cmd>lua require('fzf-lua').lsp_declarations()<cr>", opts)
keymap("n", "<leader>fi", "<cmd>lua require('fzf-lua').lsp_implementations()<cr>", opts)
keymap("n", "<leader>fp", "<cmd>lua require('user.preview-impl').preview_definition()<cr>", opts)
keymap("n", "<leader>fu", "<cmd>lua require('fzf-lua').resume()<cr>", opts)

keymap("n", "<leader>b", "<cmd>lua require('fzf-lua').buffers()<cr>", opts)
-- Symbols
keymap("n", "<leader>s", "<cmd>lua require('fzf-lua').lsp_document_symbols({show_line = true, symbols = {'function', 'method', 'class', 'module', 'interface', 'struct', 'constructor'}})<cr>", opts)
keymap("n", "<leader>s",
  "<cmd>lua require('fzf-lua').lsp_document_symbols({ show_line = true, symbols = { 'function', 'method', 'class', 'module', 'interface', 'struct', 'constructor' }, filter = function(sym) return sym.kind ~= vim.lsp.protocol.SymbolKind.Variable and sym.kind ~= vim.lsp.protocol.SymbolKind.Field and sym.kind ~= vim.lsp.protocol.SymbolKind.Property end })<cr>", opts)

keymap("n", "<leader>vs", "<cmd>lua require('fzf-lua').lsp_document_symbols({show_line = true, symbols = {'function', 'method', 'class', 'module', 'interface', 'struct', 'variable', 'constructor', 'field', 'property'}})<cr>", opts)
-- More symbols (same as above for fzf-lua, filtering is done in the picker)
keymap("n", "<leader>vs", "<cmd>lua require('fzf-lua').lsp_document_symbols()<cr>", opts)
keymap("n", "<leader>gs", "<cmd>lua require('fzf-lua').git_status()<cr>", opts)


-- RecentDir related keymap
keymap("n", "<leader>red", "<cmd>RecentDir<cr>", opts)

-- ConTeXt
vim.keymap.set("n", "[c", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })


-- Gitsigns
keymap("n", "<leader>gbl", "<cmd>Gitsigns blame_line<cr>", opts)
keymap("n", "<leader>gb", "<cmd>Gitsigns blame<cr>", opts)
keymap("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", opts)
keymap("n", "<leader>g+", "<cmd>Gitsigns stage_hunk<cr>", opts)
keymap("n", "<leader>g-", "<cmd>Gitsigns reset_hunk<cr>", opts)
keymap("n", "<leader>[", "<cmd>Gitsigns prev_hunk<cr>", opts)
keymap("n", "<leader>]", "<cmd>Gitsigns next_hunk<cr>", opts)

-- aerial
keymap("n", "<leader>a", "<cmd>AerialToggle!<CR>", opts)

-- Markdown preview
keymap("n", "<leader>p", "<cmd>MarkdownPreview<cr>", opts)
keymap("n", "<leader>P", "<cmd>MarkdownPreview<cr>", opts)

-- folding

-- Copy Path
vim.keymap.set("n", "<leader>cp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  print("Copied: " .. path)
end, { desc = "Copy file path" })

vim.keymap.set("n", "<leader>cr", function()
  vim.fn.setreg("+", vim.fn.expand("%"))
end, { desc = "Copy relative path" })

vim.keymap.set("n", "<leader>cf", function()
  vim.fn.setreg("+", vim.fn.expand("%:t"))
end, { desc = "Copy filename" })

vim.keymap.set("n", "<leader>cl", function()
  local path = vim.fn.expand("%:p")
  local lineno = vim.fn.line(".")
  local result = "@" .. path .. "#" .. lineno
  vim.fn.setreg("+", result)
  print("Copied: " .. result)
end, { desc = "Copy path#lineno" })


vim.keymap.set("n", "<leader>z", function()
  vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle line wrap" })


vim.keymap.set("i", "<M-BS>", "<C-w>", { noremap = true })
vim.keymap.set("n", "<leader>r", ":e!<cr>", { noremap = true })
vim.keymap.set("n", "<leader>w", ":w<cr>", { noremap = true })

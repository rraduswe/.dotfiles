vim.g.mapleader = " "
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }

map("n", "<leader>h", "<CMD>wincmd h<CR>", opts)
map("n", "<leader>j", "<CMD>wincmd j<CR>", opts)
map("n", "<leader>k", "<CMD>wincmd k<CR>", opts)
map("n", "<leader>l", "<CMD>wincmd l<CR>", opts)

map("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
map("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = true })

map("n", "<leader>r", ":%s///g<Left><Left>", opts)
map("n", "<leader>rc", ":%s///gc<Left><Left><Left>", opts)

map("n", "<leader>e", ":m .-2<CR>", opts)
map("n", "<leader>q", ":m .+1<CR>", opts)

map("n", "<leader>cc", ":nohl<CR>", { noremap = true })

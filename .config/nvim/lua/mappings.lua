local M = {}

function M.init()
    vim.g.mapleader = ' '
    local map = vim.api.nvim_set_keymap
    map('n', '<Space>', '<NOP>', { noremap = true, silent = true })

    map('n', '<leader>h', '<CMD>wincmd h<CR>', { noremap = true, silent = false })
    map('n', '<leader>j', '<CMD>wincmd j<CR>', { noremap = true, silent = false })
    map('n', '<leader>k', '<CMD>wincmd k<CR>', { noremap = true, silent = false })
    map('n', '<leader>l', '<CMD>wincmd l<CR>', { noremap = true, silent = false })

    map('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
    map('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true })

    map('n', '<leader>r', ':%s///g<Left><Left>', { noremap = true, silent = false })
    map('n', '<leader>rc', ':%s///gc<Left><Left><Left>', { noremap = true, silent = false })

    map('n', '<leader>e', ':m .-2<CR>', { noremap = true, silent = false })
    map('n', '<leader>q', ':m .+1<CR>', { noremap = true, silent = false })

    map('n', '<leader>cc', ':nohl<CR>', { noremap = true })
end

return M

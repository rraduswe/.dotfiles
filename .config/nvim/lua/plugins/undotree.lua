local M = {}

function M.init()
    local map = vim.api.nvim_set_keymap
    map("n", "<leader>u", ":UndotreeShow<CR>", { noremap = true })
end

return M

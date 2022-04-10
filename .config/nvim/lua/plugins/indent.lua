local M = {}

function M.init()
    vim.opt.list = true
    vim.opt.listchars:append("space:⋅")

    local indent = require("indent_blankline")

    indent.setup{
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
    }
end

return M

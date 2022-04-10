local M = {}

function M.init()
    local autopairs = require('nvim-autopairs')

    autopairs.setup({
        disable_filetype = { 'TelescopePrompt' , 'vim' },
        enable_moveright = true,
        enable_check_bracket_line = true,
        break_line_filetype = nil,
        check_ts = true
    })
end

return M

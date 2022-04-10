local M = {}

function M.init()
    local devicons = require('nvim-web-devicons')
    devicons.setup{
        default = true
    }

    local lualine = require('lualine')
    lualine.setup{
        options = {
            theme = 'tokyonight',
            section_separators = { left = '', right = '' },
            component_separators = { left = "", right = "" }, -- 
            icons_enabled = true,
            always_divide_middle = true
        },
        sections = {
            lualine_a = { {'mode', upper = true} },
            lualine_b = { {'branch', icon = ''} },
            lualine_c = { {'filename', file_status = true}, { "diagnostics", sources = { "nvim_diagnostic" } } },
            lualine_x = { 'encoding' },
            lualine_y = { 'filetype' },
            lualine_z = { 'location' },
        },
        extensions = { 'fzf', 'nvim-tree' },

    }
end

return M

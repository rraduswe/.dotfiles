local M = {}

function M.init()
    local treesitter = require('nvim-treesitter.configs')

    treesitter.setup{
        ensure_installed = 'all',
        ignore_install = { 'haskell' },
        highlight = { enable = true },
        autotag = { enable = true },
        rainbow = {
            enable = true,
            extended_mode = false,
            disable = { "html" }
        },
        autopairs = { enable = true }
    }
end

return M

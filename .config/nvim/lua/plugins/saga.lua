local M = {}

function M.init()
    local saga = require'lspsaga'

    saga.init_lsp_saga{
        use_saga_diagnostic_sign = true,
        error_sign = ' ',
        warn_sign = ' ',
        hint_sign = ' ',
        infor_sign = ' ',
        dianostic_header_icon = 'D',
        --code_action_icon = '💡',
        code_action_icon = '',
        code_action_prompt = {
            enable = true,
            sign = true,
            sign_priority = 20,
            virtual_text = false
        },
        finder_definition_icon = 'F',
        finder_reference_icon = 'R',
        max_preview_lines = 10,
        finder_action_keys = {
            open = 'o',
            vsplit = 'v',
            split = 's',
            quit = 'q',
            scroll_down = '<C-f>',
            scroll_up = '<C-b>',
        },
        code_action_keys = {
            quit = 'q',
            exec = '<CR>',
        },
        rename_action_keys = {
            quit = '<C-c>',
            exec = '<CR>',
        },
        definition_preview_icon = 'D',
        border_style = "round",
        rename_prompt_prefix = '➤'
    }

    local map = vim.api.nvim_set_keymap
    map('n', '<leader>ca', '<CMD>lua require("lspsaga.codeaction").code_action()<CR>', { noremap = true, silent = false })
end

return M

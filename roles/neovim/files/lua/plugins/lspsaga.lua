local saga = require("lspsaga")

saga.init_lsp_saga({
    border_style = "rounded",
    move_in_saga = {
        prev = "j",
        next = "k",
    },
    diagnostic_header = {
        ' ',
        ' ',
        ' ',
        ' ',
    },
    show_diagnostic_source = true,
    diagnostic_source_bracket = {},
    code_action_icon = ' ',
    code_action_num_shortcut = true,
    code_action_lightbulb = {
        enable = true,
        sign = true,
        sign_priority = 20,
        virtual_text = true,
    },
    finder_separator = " ",
    max_preview_lines = 10,
    finder_action_keys = {
        open = "o",
        vsplit = "v",
        split = "s",
        tabe = "t",
        quit = "q",
        scroll_down = "<C-f>",
        scroll_up = "<C-b>",
    },
    code_action_keys = {
        quit = "q",
        exec = "<CR>",
    },
    rename_action_quit = "<C-c>",
    definition_preview_icon = " ",
    symbol_in_winbar = false,
    winbar_separator = '➤',
    winbar_show_file = true,
    server_filetype_map = {},
})

local action = require("lspsaga.codeaction")
vim.keymap.set("n", "<leader>ca", action.code_action, { noremap = true, silent = true })

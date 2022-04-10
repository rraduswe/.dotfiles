local M = {}

function M.init()
    vim.g.kommentary_create_default_mappings = false

    local kommentary = require('kommentary.config')

    kommentary.configure_language({ "go", "javascript", "typescript", "cs", "java" }, {
        ignore_whitespace = true,
        use_consistent_indentation = true,
        single_line_comment_string = "//",
        multi_line_comment_strings = { "/*", "*/" }
    })

    kommentary.configure_language("sql", {
        ignore_whitespace = true,
        use_consistent_indentation = true,
        single_line_comment_string = "--",
        multi_line_comment_strings = { "/*", "*/" }
    })

    local map = vim.api.nvim_set_keymap
    map("n", "<leader>//", "<Plug>kommentary_line_default", {})
    map("n", "<leader>/", "<Plug>kommentary_motion_default", {})
    map("x", "<leader>/", "<Plug>kommentary_visual_default", {})
end

return M

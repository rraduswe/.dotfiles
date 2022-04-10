local M = {}

function M.init()
    vim.g.dap_virtual_text = true

    local dapui = require("dapui")
    dapui.setup({
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
            expand = { "<CR>" },
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
        },
        sidebar = {
            elements = {
                { id = "stacks", size = 0.25 },
                { id = "breakpoints", size = 0.25 },
                {
                    id = "scopes",
                    size = 0.25
                },
                { id = "watches", size = 00.25 }
            },
            size = 40,
            position = "left"
        },
        tray = {
            elements = { "repl" },
            size = 10,
            position = "bottom",
        },
        floating = {
            max_height = nil, 
            max_width = nil, 
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
        windows = { indent = 1 },
    })

    local map = vim.api.nvim_set_keymap
    map("v", "<leader>de", "<CMD>lua require("dapui").eval()", { noremap = true })
end

return M

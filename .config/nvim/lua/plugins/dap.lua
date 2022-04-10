local M = {}

function M.init()
    local home = os.getenv('HOME')
    local dap = require('dap')

    dap.adapters.go = {
        type = 'executable',
        command = 'node',
        args = { home .. '/.config/nvim/dap/vscode-go/dist/debugAdapter.js' }
    }

    dap.configurations.go = {
        {
            type = 'go',
            name = 'Debug',
            request = 'launch',
            showLog = false,
            program = "${file}",
            dlvToolPath = home .. '/go/bin/dlv'
        }
    }

    dap.configurations.node2 = {
        type = 'executable',
        command = 'node',
        args = {home .. '/.config/nvim/dap/vscode-node-debug2/out/src/nodeDebug.js'}
    }

    dap.adapters.netcoredbg = {
        type = 'executable',
        command = home .. '/.config/nvim/dap/netcoredbg/netcoredbg',
        args = {'--interpreter=vscode'}
    }

    dap.configurations.cs = {
        {
            type = "netcoredbg",
            name = "launch - netcoredbg",
            request = "launch",
            program = function()
                return vim.fn.input('Path to dll ', vim.fn.getcwd(), 'file')
            end,
        }
    }

    dap.configurations.java = {
        {
            type = "java",
            name = "Debug (Attach)",
            request = "launch",
            javaExec = "java",
        }
    }

    vim.fn.sign_define('DapBreakpoint', { text='🛑', texthl='', linehl='', numhl='' })
    vim.fn.sign_define('DapBreakpointCondition', { text='🟠', texthl='', linehl='', numhl='' })
    vim.fn.sign_define('DapBreakpointRejected', { text='⛔', texthl='', linehl='', numhl='' })

    local map = vim.api.nvim_set_keymap
    map('n', '<leader>dd', '<CMD>lua require("dapui").toggle()<CR> <bar> <CMD>lua require("dap").continue()<CR>', { noremap = true, silent = false })
    map('n', '<leader>db', '<CMD>lua require("dap").toggle_breakpoint()<CR>', { noremap = true, silent = false })
    map('n', '<leader>dbc', '<CMD>lua require("dap").set_breakpoint(vim.fn.input("Condition: "))<CR>', { noremap = true, silent = true })
    map('n', '<leader>dj', '<CMD>lua require("dap").step_over()<CR>', { noremap = true, silent = false })
    map('n', '<leader>dl', '<CMD>lua require("dap").step_into()<CR>', { noremap = true, silent = false })
    map('n', '<leader>dh', '<CMD>lua require("dap").step_out()<CR>', { noremap = true, silent = true })
end

return M

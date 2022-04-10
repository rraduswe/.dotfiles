local M = {}

function M.init()
    vim.g.nvim_tree_show_icons = {
	    git = 1,
    	folders = 1,
    	files = 1,
    	folder_arrows = 1
    }

    vim.g.nvim_tree_icons = {
        default = "",
        symlink = "",
        git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌"
        },
        folder = {
            arrow_open = "",
            arrow_closed = "",
            default = "",
            open = "",
            empty = "", -- 
            empty_open = "",
            symlink = "",
            symlink_open = ""
        }
    }

    vim.g.nvim_tree_create_in_closed_folder = 1

    local tree = require('nvim-tree')
    local events = require('nvim-tree.events')

    tree.setup {
        auto_reload_on_write = true,
        disable_netrw = true,
        hijack_netrw = true,
        hijack_cursor = true,
        open_on_setup = false,
        open_on_tab = false,
        update_cwd = false,
        update_focused_file = {
            enable = false,
            update_cwd = false,
            ignore_list = {}
        },
        system_open = {
            cmd = nil,
            args = {}
        },
        filters = {
            dotfiles = false,
            custom = {}
        },
        git = {
            enable = true,
            ignore = true,
            timeout = 500
        },
        hijack_directories = {
            enable = true,
            auto_open = true
        },
        view = {
            width = 40,
            side = 'left',
            auto_resize = false,
            signcolumn = 'yes',
            mappings = {
                custom_only = false,
                list = {}
            }
        },
        actions = {
            open_file = {
                quit_on_open = 1
            }
        }
    }

    events.on_nvim_tree_ready(function()
        vim.cmd("NvimTreeRefresh")
    end)

    local map = vim.api.nvim_set_keymap
    map('n', '<leader>ft', ':NvimTreeToggle<CR>', { noremap = true, silent = false })
end

return M

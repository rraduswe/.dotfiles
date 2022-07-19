local tree = require("nvim-tree")
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
local events = require("nvim-tree.events")

tree.setup {
    auto_reload_on_write = true,
    create_in_closed_folder = false,
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    open_on_setup = false,
    open_on_tab = false,
    sort_by = "case_sensitive",
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
        custom = {
          "^\\.git"
        }
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
        side = "left",
        signcolumn = "yes",
        mappings = {
            custom_only = false,
            list = {
              { key = 'R', cb = tree_cb('refresh') },
            }
        }
    },
    renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        highlight_opened_files = "all",
        root_folder_modifier = ":~",
        indent_markers = {
            enable = false,
            icons = {
                corner = "└ ",
                edge = "│ ",
                none = "  ",
            },
        },
        icons = {
            webdev_colors = true,
            git_placement = "before",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
    actions = {
        open_file = {
            quit_on_open = true
        }
    },
}

events.on_nvim_tree_ready(function()
    vim.cmd("NvimTreeRefresh")
end)

local map = vim.api.nvim_set_keymap
map("n", "<leader>ft", ":NvimTreeToggle<CR>", { noremap = true, silent = false })

local M = {}

function M.init()
    local telescope = require('telescope')

    telescope.setup {
	    defaults = {
      	    file_ignore_patterns = {
                "%.git/.*",
                "node_modules/.*",
                "secret.d/.*",
                "%.pem",
                "bin/.*",
                "obj/.*"
	        }
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,  
                case_mode = "smart_case",    
            },
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
            }
        }
    }

    telescope.load_extension('fzf')
    telescope.load_extension('fzy_native')

    local map = vim.api.nvim_set_keymap
    map('n', '<leader>fe', '<CMD>lua require("telescope.builtin").file_browser{cwd = vim.fn.expand("%:p:h")}<CR>', { noremap = true })
    map('n', '<leader>ff', '<CMD>lua require("telescope.builtin").find_files{ hidden = true }<CR>', { noremap = true })
    map('n', '<leader>fs', '<CMD>lua require("telescope.builtin").live_grep()<CR>', { noremap = true })
    map('n', '<leader>fb', '<CMD>lua require("telescope.builtin").buffers()<CR>', { noremap = true })
    map('n', '<leader>fh', '<CMD>lua require("telescope.builtin").help_tags()<CR>', { noremap = true })
end

return M

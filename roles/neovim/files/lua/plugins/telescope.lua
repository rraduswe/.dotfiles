local telescope = require('telescope')

telescope.setup({
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
})

telescope.load_extension('fzf')
telescope.load_extension('fzy_native')


local map = vim.api.nvim_set_keymap
local opts = { noremap = true }

map('n', '<leader>fe', '<CMD>lua require("telescope.builtin").file_browser{cwd = vim.fn.expand("%:p:h")}<CR>', opts)
map('n', '<leader>ff', '<CMD>lua require("telescope.builtin").find_files{ hidden = true }<CR>', opts)
map('n', '<leader>fs', '<CMD>lua require("telescope.builtin").live_grep()<CR>', opts)
map('n', '<leader>fb', '<CMD>lua require("telescope.builtin").buffers()<CR>', opts)
map('n', '<leader>fh', '<CMD>lua require("telescope.builtin").help_tags()<CR>', opts)
map('n', '<leader>fd', '<CMD>lua require("telescope.builtin").diagnostics()<CR>', opts)

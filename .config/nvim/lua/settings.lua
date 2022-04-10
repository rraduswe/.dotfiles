local M = {}

function M.init()
    vim.cmd('syntax on')
    vim.cmd('filetype plugin indent on')

    vim.o.errorbells = false
    vim.o.swapfile = false
    vim.o.backup = false
    vim.o.writebackup = false
    vim.o.hlsearch = true
    vim.o.incsearch = true
    vim.o.hidden = true
    vim.o.fileencoding = 'utf-8'
    vim.o.cmdheight = 2
    vim.o.shortmess = vim.o.shortmess .. 'c'
    vim.o.termguicolors = true
    vim.o.splitright = true
    vim.o.showmode = false
    vim.o.updatetime = 50
    vim.o.ignorecase = true
    vim.o.scrolloff = 4
    vim.o.clipboard = "unnamedplus"

    vim.wo.wrap = false
    vim.wo.number = true
    vim.wo.relativenumber = true

    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.smartindent = true
    vim.opt.expandtab = true 
    vim.opt.lazyredraw = true
    vim.opt.list = true
    vim.opt.listchars:append("space:⋅")

    vim.g.loaded_matchparen        = 1
    vim.g.loaded_matchit           = 1
    vim.g.loaded_logiPat           = 1
    vim.g.loaded_rrhelper          = 1
    vim.g.loaded_tarPlugin         = 1
    vim.g.loaded_gzip              = 1
    vim.g.loaded_zipPlugin         = 1
    vim.g.loaded_2html_plugin      = 1
    vim.g.loaded_shada_plugin      = 1
    vim.g.loaded_spellfile_plugin  = 1
    vim.g.loaded_netrw             = 1
    vim.g.loaded_netrwPlugin       = 1
    vim.g.loaded_tutor_mode_plugin = 1
    vim.g.loaded_remote_plugins    = 1

    vim.cmd('set undodir=~/.config/nvim/undodir')
    vim.cmd('set undofile')
    vim.cmd('highlight ColorColumn ctermbg=0 guibg=grey')
    vim.cmd('set colorcolumn=80')
end

return M

require("plugins").init()
require("settings").init()
require("mappings").init()

vim.cmd("autocmd VimEnter * doautocmd FileType")

local M = {}

function M.init()
    local home = os.getenv('HOME')
    local formatter = require('formatter')

    local prettier = function()
	    return {
		    exe = 'prettier',
			args = {
                '--stdin-filepath',
                vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                '--single-quote'
            },
			stdin = true,
		}
    end


    formatter.setup{
        filetype = {
            go = {
                function()
                    return {
                        exe = 'gofmt',
                        args = {
                            '-w',
                            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
                        },
                        stdin = false
                    }
                end,
                function()
                    return {
                        exe = 'goimports',
                        args = {
                            '-w',
                            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
                        },
                        stdin = false
                    }
                end
            },
            typescript = {
                prettier
            },
            javascript = {
                prettier
		    },
            json = {
                prettier
            }
        }
    }

    vim.api.nvim_exec([[
        augroup FormatAutogroup
            autocmd!
            autocmd BufWritePost *.go,*.ts,*.js FormatWrite
        augroup end
    ]], true)
end

return M

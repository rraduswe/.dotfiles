local M = {}

function M.init()
    local home = os.getenv("HOME")
    local formatter = require("formatter")

    local prettier = function()
	    return {
		    exe = "prettier",
			args = {
                "--stdin-filepath",
                vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                "--single-quote"
            },
			stdin = true,
		}
    end


    formatter.setup{
        filetype = {
            go = {
                function()
                    return {
                        exe = "gofmt",
                        args = {
                            "-w",
                            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
                        },
                        stdin = false
                    }
                end,
                function()
                    return {
                        exe = "goimports",
                        args = {
                            "-w",
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
            java = {
                function()
                    return {
                        exe = "java",
                        args = {
                            "-jar",
                            home .. "/.config/nvim/lsp/jdtls/format/google-java-format.jar",
                            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0))
                        },
                        stdin = true
                    }
                end
            },
            json = {
                prettier
            }
        }
    }

    vim.api.nvim_exec([[
        augroup FormatAutogroup
            autocmd!
            autocmd BufWritePost *.go,*.ts,*.js,*.java FormatWrite
        augroup end
    ]], true)
end

return M

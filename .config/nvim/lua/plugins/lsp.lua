local M = {}

function M.init()
    local home = os.getenv("HOME")
    local lspconfig = require("lspconfig")

    local on_attach = function(client, bufnr)
        local map = vim.api.nvim_buf_set_keymap
        map(bufnr, "n", "<leader>gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = false })
        map(bufnr, "n", "<leader>gd", "<CMD>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = false })
        map(bufnr, "n", "<leader>gt", "<CMD>lua vim.lsp.buf.type_definition()<CR>", { noremap = true, silent = false })
        map(bufnr, "n", "<leader>gi", "<CMD>lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = false })
        map(bufnr, "n", "<leader>gj", "<CMD>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = false })
        map(bufnr, "n", "<leader>gk", "<CMD>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = false })
        map(bufnr, "n", "<leader>gr", "<CMD>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = false })
        map(bufnr, "n", "<leader>rr", "<CMD>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = false })
        map(bufnr, "n", "<leader>h", "<CMD>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

    lspconfig.gopls.setup{
        on_attach = on_attach,
        autostart = true,
        cmd = { "gopls" },
        settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } },
        init_options = { usePlaceholders = true, completeUnimported = true },
        filetypes = { "go", "gomod" },
        root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
        single_file_support = true,
        capabilities = capabilities
    }

    lspconfig.tsserver.setup{
        on_attach = on_attach,
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx"
        },
        init_options = {
            hostInfo = "neovim"
        },
        root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
        capabilities = capabilities
    }

    local omnisharp_cmd = home .. "/.config/nvim/lsp/omnisharp/run"
    lspconfig.omnisharp.setup{
        on_attach = on_attach,
        cmd = {
            omnisharp_cmd,
            "--languageserver",
            "--hostPID",
            tostring(vim.fn.getpid())
        },
        filetypes = { "cs", "vb" },
        on_new_config = function(new_config, new_root_dir)
          if new_root_dir then
            table.insert(new_config.cmd, "-s")
            table.insert(new_config.cmd, new_root_dir)
          end
        end,
        root_dir = lspconfig.util.root_pattern(".git", "*.sln"),
        capabilities = capabilities
    }

    lspconfig.rust_analyzer.setup{
        on_attach = on_attach,
        cmd = { "rust-analyzer" },
        filetypes = { "rust", "rs" },
        root_dir = lspconfig.util.root_pattern("Cargo.toml", "rust-project.json"),
        settings = {
            ["rust-analyzer"] = {}
        },
        capabilities = capabilities
    }

    lspconfig.tailwindcss.setup{}

    lspconfig.eslint.setup{}

    lspconfig.golangci_lint_ls.setup{}

    lspconfig.jsonls.setup {}

    local signature = require("lsp_signature")
    signature.setup({
        bind = true,
        handler_opts = {
            border = "single"
        }
    })

    vim.api.nvim_exec([[
        augroup EslintAutogroup
            autocmd!
            autocmd BufWritePre *.ts,*.tsx,*.js,*.jsx EslintFixAll
        augroup end
    ]], true)

end

return M

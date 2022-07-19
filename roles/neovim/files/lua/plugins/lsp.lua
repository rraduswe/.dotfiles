local lspconfig = require("lspconfig")

local home = os.getenv("HOME")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(client, bufnr)
    local opts = { buffer = 0 }

    vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>gh", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>gs", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, opts)
end

lspconfig.gopls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    autostart = true,
    cmd = { "gopls" },
    settings = {
        gopls = {
            experimentalPostfixCompletions = true,
            analyses = {
                unusedParams = true,
                shadow = true
            },
            staticcheck = true
        }
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true
    },
    filetypes = { "go", "gomod" },
    root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
    single_file_support = true,
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
        border = "rounded"
    }
})

vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('EslintAutogroup', {
        clear = true
    }),
    pattern = { '*.js', '*.ts', '*.tsx' },
    command = 'EslintFixAll'
})

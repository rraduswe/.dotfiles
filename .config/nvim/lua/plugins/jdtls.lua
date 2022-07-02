local function on_attach(client, bufnr)
    require("jdtls").setup_dap({ hotcodereplace = "auto" })
    require("jdtls").setup_dap_main_class_configs()
    require("jdtls.setup").add_commands()

    local signature = require("lsp_signature")
    signature.on_attach({
        bind = true,
        handler_opts = {
            border = "rounded"
        }
    }, bufnr)
end

function start_jdtls()
    local home = os.getenv("HOME")
    local root_markers = {".git", "pom.xml"}
    local root_dir = require("jdtls.setup").find_root(root_markers)

    local capabilities = {
        workspace = {
            configuration = true
        },
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true
                }
            }
        }
    }

    local workspace_folder = home .. "/workspace"
    local config = {
        flags = {
            allow_incremental_sync = true,
        },
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "java" },
    }

    config.settings = {
        ["java.format.settings.url"] = home .. "/.config/nvim/lsp/jdtls/java-google-formatter.xml",
        ["java.format.settings.profile"] = "GoogleStyle",
        java = {
            signatureHelp = { enabled = true };
            contentProvider = { preferred = "fernflower" };
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*"
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*",
                    "sun.*",
                },
            };
            sources = {
                organizeImports = {
                    starThreshold = 9999;
                    staticStarThreshold = 9999;
                };
            };
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                },
                hashCodeEquals = {
                    useJava7Objects = true,
                },
                useBlocks = true,
            };
        };
    }

    config.cmd = { home .. "/.config/nvim/lsp/jdtls/java-lsp.sh", workspace_folder }
    config.root_dir = root_dir
    config.on_attach = on_attach
    config.on_init = function(client, _)
        client.notify("workspace/didChangeConfiguration", { settings = config.settings })
    end

    local jar_patterns = {
        "/.config/nvim/dap/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
        "/.config/nvim/dap/vscode-java-decompiler/server/*.jar",
        "/.config/nvim/dap/vscode-java-test/server/*.jar"
    }

    local bundles = {}
    for _, jar_pattern in ipairs(jar_patterns) do
        for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), "\n")) do
            if not vim.endswith(bundle, "com.microsoft.java.test.runner.jar") then
                table.insert(bundles, bundle)
            end
        end
    end

    local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    config.init_options = {
        bundles = bundles;
        extendedClientCapabilities = extendedClientCapabilities;
    }

    local jdtls_ui = require("jdtls.ui")
    function jdtls_ui.pick_one_async(items, _, _, cb)
        require("lsputil.codeAction").code_action_handler(nil, items, nil, nil, cb)
    end

    local map = vim.api.nvim_buf_set_keymap
    map(0, "n", "<leader>ca", "<CMD>lua require(\"jdtls\").code_action()<CR>", { noremap = true, silent = true })

    require("jdtls").start_or_attach(config)
end


vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('StartJdtls', {
        clear = true
    }),
    pattern = '*.java',
    callback = start_jdtls
})

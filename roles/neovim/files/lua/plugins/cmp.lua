local cmp = require('cmp')
local types = require("cmp.types")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local lspkind = require("lspkind")

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
    enabled = true,
    completion = {
        completeopt = "menu,menuone,noinsert",
        autocomplete = {
            types.cmp.TriggerEvent.TextChanged,
        },
        get_trigger_characters = function(trigger_characters)
            return trigger_characters
        end
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    preselect = types.cmp.PreselectMode.Item,
    formatting = {
        format = lspkind.cmp_format({ with_text = true })
    },
    mapping = {
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({select = true}),
        ["<Tab>"] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif vim.fn["vsnip#available"]() == 1 then
                    feedkey("<Plug>(vsnip-expand-or-jump)", "")
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end,
            {"i", "s"}
        ),
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lsp_document_symbol" },
        { name = "vsnip" },
        { 
            name = "buffer",
            options = {
                get_bufnrs = function()
                    return vim.api.nvim_list_bufs()
                end,
            },
        },
        { name = "path" },
    }
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({
    map_cr = true, 
    map_complete = true, 
    auto_select = true,
    insert = false,
    map_char = {
        all = "(",
        tex = "{"
    }
}))

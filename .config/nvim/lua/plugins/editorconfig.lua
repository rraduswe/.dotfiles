local M = {}

function M.init()
    vim.g.EditorConfig_core_mode = "external_command"
    vim.g.EditorConfig_exec_path = "editorconfig"
end

return M

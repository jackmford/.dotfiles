vim.api.nvim_create_user_command("OpenObsidian", function()
    local vault = "Obsidian Vault"
    local file = vim.fn.expand("%:r") -- Don't encode spaces
    os.execute('open "obsidian://open?vault=' .. vault .. '&file=' .. file .. '"')
end, {})


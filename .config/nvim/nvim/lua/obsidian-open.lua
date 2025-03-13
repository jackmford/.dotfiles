vim.api.nvim_create_user_command("OpenObsidian", function()
    local vault = "Obsidian Vault"  -- Set your actual vault name
    local full_path = vim.fn.expand("%:p")  -- Get full absolute path
    local vault_path = "/Users/jackfordyce/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian Vault"

    -- Ensure we only pass the relative path within the vault
    local relative_path = full_path:gsub("^" .. vim.pesc(vault_path), ""):gsub("%.md$", "")

    if relative_path == full_path then
        print("Error: File is outside your Obsidian Vault!")
    else
        os.execute('open "obsidian://open?vault=' .. vault .. '&file=' .. relative_path .. '"')
    end
end, {})

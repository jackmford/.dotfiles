-- Path to the directory where Obsidian stores daily notes
local daily_note_dir = "/Users/jackfordyce/Library/Mobile Documents/iCloud~md~obsidian/Documents/Obsidian Vault/para/1 Projects/2025/dailys"

local Job = require("plenary.job")

local function fetch_api_data(url, callback)
  Job:new({
    command = "curl",
    args = { "-s", url },
    on_exit = function(job, return_val)
      if return_val == 0 then
        local response = table.concat(job:result(), "\n")
        -- Pass the response to the callback function
        callback(response)
      else
        -- Pass an error message if the request fails
        callback(nil, "HTTP request failed with exit code: " .. return_val)
      end
    end,
  }):start()
end

local function handle_response(response, err)
  if err then
    print("Error:", err)
    return err
  end
  print("Response received:")
  -- Process the API response (e.g., JSON decode if needed)
  vim.schedule(function()
    local data = vim.fn.json_decode(response)
    print(data.tip)

    -- Dynamically format content for the daily note
    -- Check if the buffer is empty
    if vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
      -- Define your content
    local content = {
      '## ✅ Tasks Due Today',
      '```dataview',
      'TASK',
      'FROM "para/1 Projects" OR "para/0 Inbox"',
      'WHERE contains(text, "due:") ',
      'AND date(split(text, "due:")[1]) = date(today)',
      '```',
      '',
      '## ⏰ Overdue Tasks',
      '```dataview',
      'TASK',
      'FROM "para/1 Projects" OR "para/0 Inbox"',
      'WHERE contains(text, "due:") ',
      'AND date(split(text, "due:")[1]) < date(today)',
      'AND !completed',
      'SORT date(split(text, "due:")[1]) ASC',
      '```',
      '',
      '## Notes',
      '- ',
      '',
      '## Review',
      '- [ ] Review completed tasks',
      '- [ ] Plan for tomorrow',
      '',
      string.format("Vim Tip: %s", data.tip)
    }

      -- Insert the content
      vim.api.nvim_buf_set_lines(0, 0, -1, false, content)

      -- Optionally, save the file immediately
      vim.cmd("write")
    end
  end)
end

-- Autocommand to trigger when opening a file in the daily note directory
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = daily_note_dir .. "/*.md",
  callback = function ()
    fetch_api_data("https://vimtricks.jackmitchellfordyce.com/random-tip", handle_response)
  end,
})

vim.api.nvim_create_user_command("ObsidianDailyNote", function()
  local filepath = daily_note_dir .. "/" .. os.date("%Y-%m-%d") .. ".md"
  vim.cmd("edit " .. filepath)
end, {})

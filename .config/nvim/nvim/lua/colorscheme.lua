-- Set the colorscheme to tokyonight using a protected call
-- in case it isn't installed
--local status, _ = pcall(vim.cmd, "colorscheme tokyonight")
local status, _ = pcall(vim.cmd, "colorscheme rose-pine-dawn")
if not status then


 print("Colorscheme not found!") -- Print an error message if the colorscheme is not installed
  return
end

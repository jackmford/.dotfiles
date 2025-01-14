vim.diagnostic.config({
  virtual_text = {
    prefix = 'x',
    spacing = 4,
  },
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})


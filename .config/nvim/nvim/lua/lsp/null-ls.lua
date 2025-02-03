local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- <https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting>
local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier.with({
      extra_args = {
        "--prose-wrap", "always",
        "--print-width", "100",
        "--no-semi", "--single-quote",
        "--jsx-single-quote"
      }
    }),
    formatting.black.with({
      extra_args = {
        "-l", "90",
        "--preview",
        "--fast"
      }
    }),
  },
})

local servers = {
  "lua_ls",
  "cssls",
  "html",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  "vimls",
  "markdown_oxide",
  "eslint",
  "vtsls",
  "ansiblels",
  "gopls",
  "terraformls",
}


require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

require("mason-lspconfig").setup_handlers {
  function (server_name)
    require("lspconfig")[server_name].setup {}
  end,
}


-- get rid of undefined global vim error
require('lspconfig').lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = {'vim'}
      }
    }
  }
})

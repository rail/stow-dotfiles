---@type LazySpec
return {
  -- {
  --   "jay-babu/mason-null-ls.nvim",
  --   optional = true,
  --   opts = function(_, opts)
  --     opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "crlfmt" })
  --   end,
  -- },
  {
    "stevearc/conform.nvim",
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters = {
        crlfmt = {
          command = "crlfmt",
        },
      },
      formatters_by_ft = {
        go = { "crlfmt" },
      },
    },
  },
}

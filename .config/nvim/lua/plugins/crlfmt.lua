---@type LazySpec
return {
  --[[
    yq ea '[.]' -o json packages/crlfmt/package.yaml > registry.json
    zip -r registry.json.zip registry.json
    sha256sum registry.json registry.json.zip > checksums.txt
    attach to the release
  --]]
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.registries =
        require("astrocore").list_insert_unique(opts.registries, { "github:rail/mason-registry@crlfmt" })
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "crlfmt" })
    end,
  },
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

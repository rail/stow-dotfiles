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
    opts = {
      registries = {
        "github:rail/mason-registry@crlfmt",
        "github:mason-org/mason-registry",
      },
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = { "crlfmt" },
    },
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

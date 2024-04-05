-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      inlay_hints = true, -- enable/disable inlay hints on start
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
      gopls = {
        env = {
          -- TODO: make GOPACKAGESDRIVER project-specific
          GOPACKAGESDRIVER = "./build/bazelutil/gopackagesdriver.sh",
        },
        directoryFilters = {
          "-_bazel",
          "-inflight_trace_dump",
        },
      },
    },
  },
}

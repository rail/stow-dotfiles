-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    ---@diagnostic disable: missing-fields
    config = {
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

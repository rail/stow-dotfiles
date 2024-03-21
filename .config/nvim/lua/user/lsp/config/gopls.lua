return {
  settings = {
    gopls = {
      env = {
        GOPACKAGESDRIVER = './build/bazelutil/gopackagesdriver.sh',
      },
      directoryFilters = {
        "-_bazel",
        "inflight_trace_dump",
      }
    }
  }
}

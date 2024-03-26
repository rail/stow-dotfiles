-- Rail's https://astronvim.com/ config
-- See https://docs.astronvim.com/ on how to install it and use user configs.

local options = {
  opt = {
    spell = true,
  },
}

local colorscheme = "tokyonight-night"

local lsp = {
  settings = {
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
}

local plugins = {
  { "AstroNvim/astrocommunity", { import = "astrocommunity.pack.go" } },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble", "TroubleToggle" },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "User AstroFile",
    opts = {},
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        hover = { enabled = false },
        signature = { enabled = false },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "mhartington/formatter.nvim",
    cmd = { "FormatWrite", "Format" },
    opts = {
      filetype = {
        go = {
          -- Defines `crlfmt` as a formatter for Go files.
          -- It will be run as a part of :Format or FormatSave
          function()
            return {
              exe = "crlfmt",
              stdin = true,
            }
          end,
        },
      },
    },
  },
}

-- Open last position instead of the top of a file.
local remember_last_position = function()
  vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function(opts)
      local ft = vim.bo[opts.buf].filetype
      if ft:match "commit" or ft:match "rebase" then return end
      local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
      if { row, col } ~= { 0, 0 } then vim.api.nvim_win_set_cursor(0, { row, col }) end
    end,
  })
end

-- Run crlfmt on save
local crlfmt_save = function()
  vim.api.nvim_create_augroup("__formatter__", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.go",
    group = "__formatter__",
    command = ":FormatWrite",
  })
end

local polish = function()
  remember_last_position()
  crlfmt_save()
end

return {
  colorscheme = colorscheme,
  options = options,
  polish = polish,
  plugins = plugins,
  lsp = lsp,
}

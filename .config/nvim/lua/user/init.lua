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
    "lewis6991/gitsigns.nvim",
    keys = { { "<leader>gT", "<cmd>Gitsigns toggle_current_line_blame<cr>" }, desc = "Toggle current line blame" },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "mhartington/formatter.nvim",
    ft = "go",
    opts = {
      filetype = {
        go = {
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

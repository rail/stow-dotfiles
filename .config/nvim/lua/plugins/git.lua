return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "gitlint" })
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Git files" },
    },
  },
}

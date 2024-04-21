-- You can also add or configure plugins by creating files in this `plugins/` folder

---@type LazySpec
return {
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
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "gitcommit" })
      end
    end,
  },
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "          ██ ▄█▀ ▄▄▄       ██▓             ",
        "          ██▄█▒ ▒████▄    ▓██▒             ",
        "         ▓███▄░ ▒██  ▀█▄  ▒██▒             ",
        "         ▓██ █▄ ░██▄▄▄▄██ ░██░             ",
        "         ▒██▒ █▄ ▓█   ▓██▒░██░             ",
        "         ▒ ▒▒ ▓▒ ▒▒   ▓▒█░░▓               ",
        "         ░ ░▒ ▒░  ▒   ▒▒ ░ ▒ ░             ",
        "         ░ ░░ ░   ░   ▒    ▒ ░             ",
        "         ░  ░         ░  ░ ░               ",
        "                                           ",
        " ██▀███   ▒█████   ▄████▄   ██ ▄█▀  ██████ ",
        "▓██ ▒ ██▒▒██▒  ██▒▒██▀ ▀█   ██▄█▒ ▒██    ▒ ",
        "▓██ ░▄█ ▒▒██░  ██▒▒▓█    ▄ ▓███▄░ ░ ▓██▄   ",
        "▒██▀▀█▄  ▒██   ██░▒▓▓▄ ▄██▒▓██ █▄   ▒   ██▒",
        "░██▓ ▒██▒░ ████▓▒░▒ ▓███▀ ░▒██▒ █▄▒██████▒▒",
        "░ ▒▓ ░▒▓░░ ▒░▒░▒░ ░ ░▒ ▒  ░▒ ▒▒ ▓▒▒ ▒▓▒ ▒ ░",
        "  ░▒ ░ ▒░  ░ ▒ ▒░   ░  ▒   ░ ░▒ ▒░░ ░▒  ░ ░",
        "  ░░   ░ ░ ░ ░ ▒  ░        ░ ░░ ░ ░  ░  ░  ",
        "   ░         ░ ░  ░ ░      ░  ░         ░  ",
        "                  ░                        ",
      }
      return opts
    end,
  },
}

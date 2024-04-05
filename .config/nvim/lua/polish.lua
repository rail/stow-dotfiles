-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

local remember_last_position = function()
  vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function(opts)
      local ft = vim.bo[opts.buf].filetype
      if ft:match "commit" or ft:match "rebase" then return end
      local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
      if row ~= 0 and col ~= 0 then vim.api.nvim_win_set_cursor(0, { row, col }) end
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

remember_last_position()
crlfmt_save()

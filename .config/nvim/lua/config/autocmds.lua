-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- nvim 実行中は Alacritty のウィンドウだけ不透明にする(終了時に元へ戻す)
local alacritty_window = vim.env.ALACRITTY_WINDOW_ID
if alacritty_window and vim.fn.executable("alacritty") == 1 then
  vim.fn.jobstart({ "alacritty", "msg", "config", "-w", alacritty_window, "window.opacity=1.0" })
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = vim.api.nvim_create_augroup("alacritty_opaque", { clear = true }),
    callback = function()
      vim.fn.system({ "alacritty", "msg", "config", "-w", alacritty_window, "--reset" })
    end,
  })
end

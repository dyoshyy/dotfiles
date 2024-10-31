-- automatically joump to end of text you pasted
vim.keymap.set('v', 'y', 'y`]')
vim.keymap.set({ 'v', 'n' }, 'p', 'p`]')

vim.keymap.set('n', 'ZZ', '<NOP>')
vim.keymap.set('n', 'ZQ', '<NOP>')

-- do not overwrite default register
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('n', 'X', '"_X')
vim.keymap.set('n', 's', '"_s')

-- leader
vim.api.nvim_set_var('mapleader', ',')
vim.api.nvim_set_var('maplocalleader', '\\')

-- window
vim.keymap.set('n', '<leader>h', '<C-w><C-h>')
vim.keymap.set('n', '<leader>j', '<C-w><C-j>')
vim.keymap.set('n', '<leader>k', '<C-w><C-k>')
vim.keymap.set('n', '<leader>l', '<C-w><C-l>')

-- buffer
vim.keymap.set('n', '<Tab>', ':bnext<CR>')
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>')

vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>')

-- Ctrl+Tabで次のタブへ
vim.api.nvim_set_keymap('n', '<C-Tab>', ':tabnext<CR>', { noremap = true, silent = true })
-- Ctrl+Shift+Tabで前のタブへ
vim.api.nvim_set_keymap('n', '<C-S-Tab>', ':tabprevious<CR>', { noremap = true, silent = true })
-- 新しいタブを作成 (Ctrl+T)
vim.api.nvim_set_keymap('n', '<C-t>', ':tabnew<CR>', { noremap = true, silent = true })
-- 現在のタブを閉じる (Ctrl+W)
vim.api.nvim_set_keymap('n', '<C-w>', ':tabclose<CR>', { noremap = true, silent = true })
-- ターミナルを開く
vim.api.nvim_set_keymap('n', 'tx', ':belowright new | terminal<CR>i', { noremap = true, silent = true })
-- <Esc>でノーマルモードに戻る
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- Ctrl + h/j/k/lでウィンドウ間を移動
vim.api.nvim_set_keymap('t', '<C-h>', '<C-\\><C-n><C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-j>', '<C-\\><C-n><C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-k>', '<C-\\><C-n><C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-l>', '<C-\\><C-n><C-w>l', { noremap = true, silent = true })

-- ターミナルモードで行番号を非表示にする
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end
})


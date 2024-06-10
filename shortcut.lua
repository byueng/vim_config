-- 设置撤销
vim.api.nvim_set_keymap('i', '<C-z>', '<C-o>u', { noremap = true, silent = true })
-- 设置 GitHub Copilot 的 Tab 键
vim.api.nvim_set_keymap('i', "<leader><Tab>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
-- 文本选择
vim.api.nvim_set_keymap('i', '<S-Left>', '<C-o>v<left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-Right>', '<C-o>v<right>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-Up>', '<C-o>v<up>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-Down>', '<C-o>v<down>', { noremap = true, silent = true })
-- 设置文本选择复制(visual mode)
vim.api.nvim_set_keymap('v', 'c', '"+y', { noremap = true, silent = true})
-- 设置文本选择剪切(visual mode)
vim.api.nvim_set_keymap('v', 'x', '"+x', { noremap = true, silent = true})
-- 移动到行尾
vim.api.nvim_set_keymap('i', '<leader>;', '<C-o>$', { noremap = true, silent = true})

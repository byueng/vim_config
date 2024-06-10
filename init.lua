-- leader key
vim.g.mapleader = ' '
-- init cmd
vim.cmd [[packadd packer.nvim]]
vim.cmd [[set number]]
vim.cmd [[colorscheme dracula]]
package.path = package.path .. ';C:/Users/jwm/AppData/Local/nvim/?.lua'

require('plugins')

require('setup')

require('shortcut')

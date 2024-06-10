-- Packer 自动安装插件
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- 自动补全插件
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-nvim-lua' 
  use 'neovim/nvim-lspconfig'
  -- 配对插件
  use 'windwp/nvim-autopairs'
  -- 语法高亮
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  
  -- dracula theme
  use 'Mofiqul/dracula.nvim'

  -- github copilot
  use 'github/copilot.vim'

  -- Python 特定的插件
  use 'psf/black'  -- Python 代码格式化
  use 'mfussenegger/nvim-dap'  -- 调试器

end)

- `git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"`
- use `:PackerInstall` to install plugins, if lua has bug, first notes the last two `require`function and `vim.cmd[[colorscheme dracula]]`, then use `:PackerInstall` to install plugins, then add the two lines back to `init.lua` and run `:PackerCompile` to compile the plugins.
- more details see in vim_config.md


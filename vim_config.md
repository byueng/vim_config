# Vim config in windows10
some envirment values:
**%env:localappdata = C:\user\username\appdata\local**
- vim config local configuration files locates in `$env:localappdata`, default in `C:\user\username\appdata\local\nvim`, if not have nvim folder, create it first. Then create `init.lua|vim` which is the stdpath configure's location.(Also create an empty one first if don't exist, at most time is `init.lua` rather than `init.vim`)

- vim custome will divide into three parts: 1. plugins management; 2. lua configuration such as background setup; 3. vim development(I think it personally, something new always need us develop then make it become a plugin). So, more important is the first two.

- just as my vim config process and no matter what is right and wrong, maybe one day this md is over.

By the way, most of this md comes from Chatgpt. At the beginnign of my vim journal, I just copieid [lazy](https://www.lazyvim.org/), it's a very credible subject but I don't like its colorscheme and some UI layout. The most speechless is I can't edit it correctly, I need read config file or try command again again and again. 

## a effient plugin management

What gpt give me the answer "introduce a nvim plugin management tool on windows which can install, update, remove plugins in present" is `Packer.nvim`. So, it becomes my first snippet in my configure.

1. install packer.nvim
```sh
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
```
another way, edit in `init.lua`

```lua
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end
```


2. edit configure file in `init.lua`
```lua
-- init.lua

-- Ensure packer is installed
vim.cmd [[packadd packer.nvim]]

~~return~~ require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Add your plugins here

end)

```

> **No `return` in your lua code**, I don't know the detail about lua program language.
> There're some blocks (one require as a block) in `init.lua`, if `return` in any block except the last one, blocks after that block will not work.

`keyword: use`: a function which provided in packer.nvim, `use <github.user>\<repo>` like a node point at the address of plugin in github.

3. Install plugins in vim
There're some new vimcommand once edit `init.lua` correctly.
- :PackerInstall
- :PackerUpdate
- :PackerClean

These commands are used with codes in `init.lua`.

```lua
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer itself
  use 'nvim-treesitter/nvim-treesitter' -- code highlight
  use 'neovim/nvim-lspconfig' -- LSP config
  use 'hrsh7th/nvim-cmp' -- code autocomplete
  use 'nvim-telescope/telescope.nvim' -- files search
  -- 添加更多插件
end)
```

### plugins maintenance
One reason why **lazyvim** is so popular is plugins maintenance, I will make it in the future.~~Maybe tomorrow~~  


## Work as an IDE
I writed code by vscode but I'm a troublemaker, I hate click mouse here and there. Always I think should use linux as my OS, then I confirmed if I use ubuntu I'll install vscode rather than vim.Just for vim, there aren't that many differences between the two OS. just say~

### lsp config
[what's `lsp`](https://en.wikipedia.org/wiki/Language_Server_Protocol)
I set `neovim/nvim-lspconfig` as my nvim lsp 

1. make sure plugins was installed.
2. run `npm i|install -g pyright`
> npm is a CLI needs to install, can install it correctly by installing Node.js.
3. add `require('lspconfig').pyright.setup{}` in `init.lua` 

After configuarting correctly, vim can check whether the code written reasonably.
such as:
![image](https://raw.githubusercontent.com/byueng/imgrepo/main/!%5Balt%20text%5D(image.png).png?token=BGPU733AYPS6BOYVFMKSOHTGMFLTY)
It says module `sys` can't accessed, like a warning in vscode which draws a yellow wavy line under the varible.

the detail config:
1. When installed cmp plugins successfully, it need some shortcut key sets to allow cmp can work correctly. The most important thing is "how to select the function what I want and how to scroll the window (if it's long enough)"
the lua code as follows:
```lua
cmp.setup({
  snippet = {
    -- select snippet plugins
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    -- set shortcut key(Only in vsnip)
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['k'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<Enter>'] = cmp.mapping.confirm({ select = true })
    -- more shorcut key
},
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    -- more source
  })
})
```

---
> tips
>> `require''()` like `#include<>` in C, so it can find external lua config file to load.
>> in lsp config, `require'lspconfig'` we can find `lspconfig.lua` in packer install path.
>> In `packer.lua` which manage plugins, 130 rows, in init function, we can find the path config.
>> So `packer.nvim` got everything done when install it.
>> But when I look for the lua doc, one method to confirm the path of require the plugins' lua file is `package.path`, then I write it in `init.lua`, there's no path what I want to get. 'Cause `packer.nvim` tells me the packers path is `$env:localappdata\nvim-data\site\pack\packer\start\.\.lua`.
>> I don't find any `package.path` config in `packer.lua`. fuck it up.

What I get:
![20240606142903](https://raw.githubusercontent.com/byueng/imgrepo/main/20240606142903.png?token=BGPU73YID2KYDNIXC52U6I3GMFLW2)


## row number display
There's a big question when your code has bug, set row number could help you find the row which exist bug.
Only one command can make it, add it in `init.lua` will work.
`vim.cmd [[set number]]`
- `:set number` display the absolute row number
- `:set relativenumber` display the relative row number, so it's a adaptive number that will change while your cursor move.


## before shorcut key map
Here need to introduce a concept: `leader key`. Leader key usually used as the trigger of some special shortcut key (set by `vim.api.nvim_set_keymap` function).
For me, I set `<Space> or ' '` as my leader key, from the perspective of using shortcut key it's definitely better than default leader key but it costs more runtime because vim waits for other commands to be issued after it. 
- 'vim.g.mapleader = ' '' can help you to set leader key

## shortcut key map
### undo
Vim has built-in shortcut key but some of them I don't adapt. And vim allow shortcut key re-map.
It's `vim.api.nvim_set_keymap`, 'cause I used to write code in vscode, my undo shortcut key usually is `<C-z>`. Besides, I want it works in insert mode. The config code is:
`vim.api.nvim_set_keymap("i", "<C-z>", "<C-o>u")`
- `"i"` means insert mode
- `"<C-z>"` means the shortcut what we want
- `"<C-o>u"` means the old shortcut that configuated in vim. `<C-o>` means execute a normal mode command once in insert mode, then return to insert mode.


### set by leader
- if one leader key is setted, more command combinations will appera by `<leader>`. An example is `vim.api.nvim_set_keymap('i', "<leader><Tab>", 'copilot#Accept("<CR>")', { silent = true, expr = true })`, it set the copilot complete command. 


## How could I miss Github copilot
I love github copilot very much. Luckily vim has its plugin.
-- use 'packer.nvim' to install 
- `use "github/copilot.vim"`
- then a code will appear and one page need to fill something
- `vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })` to set shortcut to get what copilot generates.



-- theme
require('dracula').setup({
  show_end_of_buffer = true,
  transparent_bg = true,
  italic_comment = true
})

-- cmp
local cmp = require'cmp'
cmp.setup({
  snippet = {
    -- 选择你的 snippet 插件
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    -- 定义你的按键映射(Only in  vsnip)
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['k'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<Enter>'] = cmp.mapping.confirm({ select = true })
},
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'nvim_lua' },
  })
})

-- `/` cmdline setup.
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- LSP配置
require('lspconfig').pyright.setup{}

-- 自动补全配置
require('nvim-autopairs').setup()

-- GitHub Copilot 配置
vim.g.copilot_no_tab_map = true


--[[
-- Jeremy Elalouf 2023
-- This configuration is hosted at TODO
--]]
local nvim_version = vim.version()
vim.cmd('echo \"Configuration by Jeremy Elalouf 2023\"')

-- Leader key
-- [[
-- Must be done before any vim.keymap.set() call (yes, even the plugins)
-- according to
-- https://neovim.discourse.group/t/how-to-set-leader-key-in-lua/175/6
-- ]]
vim.g.mapleader = ','

local pluginstall = require('pluginstall')

-- Colorscheme

vim.api.nvim_set_option('background', 'dark')
vim.api.nvim_command('let g:solarized_termcolors=256')
vim.api.nvim_command('let g:solarized_termtrans=1')
vim.api.nvim_command('let g:solarized_contrast="normal"')
vim.api.nvim_command('let g:solarized_visibility="normal"')
vim.api.nvim_command('color solarized')
vim.api.nvim_command('highlight! Function ctermfg=33 guifg=#40ffff')
vim.api.nvim_command('highlight clear Identifier')

-- General Options

local extended_tabs_filetypes = {'c', 'cpp'}
local no_spaced_tabs_filetypes = {'make'}
local default_tabs = 2
local extended_tabs = 4
local home_dir = '/Users/jerem'

vim.api.nvim_set_option('dir', home_dir .. '/.config/nvim/tmp')
vim.api.nvim_win_set_option(0, 'number', true)
vim.api.nvim_set_option('foldlevel', 1)

vim.api.nvim_set_option('cursorline', true)

vim.api.nvim_command('highlight clear SignColumn')
vim.api.nvim_command('highlight clear LineNr')

-- Status line

vim.api.nvim_set_option('laststatus', 2)
vim.api.nvim_set_option('statusline', '"%<%f\\')
vim.api.nvim_set_option('statusline', vim.o.statusline .. '%w%h%m%r')

vim.api.nvim_set_option('whichwrap', 'b,s,h,l,<,>,[,]')
vim.api.nvim_set_option('virtualedit', 'onemore')

-- Clipboard

vim.api.nvim_set_option('clipboard', 'unnamed,unnamedplus')

vim.api.nvim_set_option('foldclose', 'all')
vim.api.nvim_set_option('foldenable', false)
vim.api.nvim_set_option('ignorecase', true)
vim.api.nvim_set_option('shiftwidth', default_tabs)
vim.o.exrc = true

vim.api.nvim_set_keymap('i', '²', '<esc>', {})
vim.api.nvim_set_keymap('t', '²', '<c-\\><c-n>', {})
vim.api.nvim_set_keymap('', ';', ':GitFiles<cr>', {})
vim.api.nvim_set_keymap('i', '(', '()<left>', {})
vim.api.nvim_set_keymap('i', '[', '[]<left>', {})
vim.api.nvim_set_keymap('i', '{', '{}<left>', {})

-- [[
-- For faster saving and quitting
-- ]]
vim.api.nvim_set_keymap('n', 'ww', ':w<CR>', {})
vim.api.nvim_set_keymap('n', 'qq', ':q<CR>', {})
vim.api.nvim_set_keymap('n', 'qf', ':q!<CR>', {})

-- [[
-- Remap the arrow keys to move between windows
-- ]]
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W><C-J>', {})
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W><C-K>', {})
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', {})
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', {})


-- [[
-- Copilot remap
-- From: https://www.reddit.com/r/neovim/comments/qsfvki/how_to_remap_copilotvim_accept_method_in_lua/
-- ]]
vim.api.nvim_set_keymap('i', '<C-J>', 'copilot#Accept("<CR>")', {expr=true, silent=true})

--[[
-- Changes the tab length depending on filetype according to the variables on
-- top of this section.
--]]
vim.api.nvim_create_autocmd({'FileType'}, {
  callback = function ()
    vim.api.nvim_buf_set_option(0, 'expandtab', true)
    vim.api.nvim_buf_set_option(0, 'shiftwidth', default_tabs)
    vim.api.nvim_buf_set_option(0, 'tabstop', default_tabs)
    return false
  end
})

vim.api.nvim_create_autocmd({'FileType'}, {
  pattern = extended_tabs_filetypes,
  callback = function ()
    vim.api.nvim_buf_set_option(0, 'expandtab', true)
    vim.api.nvim_buf_set_option(0, 'shiftwidth', extended_tabs)
    vim.api.nvim_buf_set_option(0, 'tabstop', extended_tabs)
    return false
  end
})

-- [[
-- Switches off tabs made of spaces on specific filtypes. Configurable on top
-- of this section.
-- ]]
vim.api.nvim_create_autocmd({'FileType'}, {
  pattern = no_spaced_tabs_filetypes,
  callback = function ()
    vim.api.nvim_buf_set_option(0, 'expandtab', false)
    return false
  end
})

-- [[
-- Removes line numbers when in terminal mode
-- ]]
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function ()
    vim.o.number = false
    vim.o.relativenumber = false
  end
})

--[[
-- Removes ueseless whitespaces at the end of each line. See
-- https://vim.fandom.com/wiki/Remove_unwanted_spaces
--]]
vim.api.nvim_create_autocmd({'BufWritePre'}, {
  command = ':%s/\\s\\+$//e'
})

-- [[
-- Add lsp related shortcuts. See help lsp.
-- ]]
vim.api.nvim_create_autocmd({'LspAttach'}, {
  callback = function ()
    vim.keymap.set('n', '<Leader>=', vim.lsp.buf.format)
    vim.keymap.set('n', '<Leader>g', vim.lsp.buf.definition)
    vim.keymap.set('n', '<Leader><Space>', vim.lsp.buf.hover)
    vim.keymap.set('n', '<Leader>r', vim.lsp.buf.rename)
    vim.keymap.set('n', '<Leader>e', vim.diagnostic.goto_next)
  end
})

-- Completion options
--[[
-- Got from https://github.com/neovim/nvim-lspconfig
--]]

vim.api.nvim_set_option('completeopt', 'menuone,noinsert,noselect')

local cmp = require'cmp'
local language_servers = require'languageservers'
local cmp_nvim_lsp = require'cmp_nvim_lsp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
  }
})

cmp_nvim_lsp.default_capabilities()
language_servers.setup(cmp_nvim_lsp)

local plugconf = require('plugconf')

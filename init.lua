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

local home_dir = '/Users/jerem'

--vim.api.nvim_create_autocmd('BufWritePre', {
  --pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
  --command = 'silent! EslintFixAll',
  --group = vim.api.nvim_create_augroup('MyAutocmdsJavaScripFormatting', {}),
--})

vim.opt.undofile = true
vim.opt.undodir = home_dir .. '/.config/nvim/tmp/undo'
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'dd', 'dd', { noremap = true, silent = true })

-- General Options

local extended_tabs_filetypes = {'c', 'cpp'}
local no_spaced_tabs_filetypes = {'make'}
local default_tabs = 4
local extended_tabs = 4
local home_dir = '/Users/jerem'

vim.api.nvim_set_option('whichwrap', 'h,l')
vim.api.nvim_set_option('ve', 'onemore')

vim.api.nvim_set_option('dir', home_dir .. '/.config/nvim/tmp')
vim.api.nvim_win_set_option(0, 'number', true)
vim.api.nvim_set_option('foldlevel', 1)

vim.api.nvim_set_option('cursorline', true)

vim.api.nvim_command('highlight clear SignColumn')
vim.api.nvim_command('highlight clear LineNr')

-- Clipboard

vim.api.nvim_set_option('clipboard', 'unnamed,unnamedplus')

vim.api.nvim_set_option('foldclose', 'all')
vim.api.nvim_set_option('foldenable', false)
vim.api.nvim_set_option('ignorecase', true)
vim.api.nvim_set_option('shiftwidth', default_tabs)
vim.api.nvim_set_option('tabstop', default_tabs)
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
    vim.keymap.set('n', '<Leader>sf', vim.lsp.buf.code_action)
    vim.keymap.set('n', '<Leader>sr', vim.lsp.buf.rename)
  end
})

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

--[[
-- Arthur Soulié 2022
-- This configuration is hosted at https://github.com/ArthurS1/nvim-init
--]]
vim.cmd('echo \"Configuration by Arthur Soulié 2022\"')

-- Plugins
--[[
-- From https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom for vim
-- plug usage in lua.
--]]

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugins')
Plug('junegunn/fzf',{['do'] = vim.fn['fzf#install']})
Plug('junegunn/fzf.vim')
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-vsnip')
Plug('hrsh7th/vim-vsnip')
vim.call('plug#end')

-- General Options

local extended_tabs_filetypes = {'c', 'cpp'}
local default_tabs = 2
local extended_tabs = 4

vim.api.nvim_set_option('dir', '$HOME/.config/nvim/tmp')
vim.api.nvim_win_set_option(0, 'number', true)
vim.api.nvim_win_set_option(0, 'relativenumber', true)
vim.api.nvim_buf_set_option(0, 'expandtab', true)
vim.api.nvim_buf_set_option(0, 'shiftwidth', default_tabs)
vim.api.nvim_buf_set_option(0, 'tabstop', default_tabs)
vim.api.nvim_set_option('foldlevel', 1)
vim.api.nvim_set_option('foldclose', 'all')
vim.api.nvim_set_option('foldenable', false)

vim.api.nvim_set_keymap('i', '²', '<Esc>', {})
vim.api.nvim_set_keymap('t', '²', '<C-\\><C-n>', {})
vim.api.nvim_set_keymap('', ';', ':Files<CR>', {})
vim.api.nvim_set_keymap('i', '(', '()<left>', {})
vim.api.nvim_set_keymap('i', '[', '[]<left>', {})
vim.api.nvim_set_keymap('i', '{', '{}<left>', {})

--[[
-- Changes the tab length depending on filetype according to the variables on
-- top of this section.
--]]
vim.api.nvim_create_autocmd({'FileType'}, {
  pattern = extended_tabs_filetypes,
  callback = function ()
    vim.api.nvim_buf_set_option(0, 'shiftwidth', extended_tabs)
    vim.api.nvim_buf_set_option(0, 'tabstop', extended_tabs)
    return false
  end
})

--[[
-- Removes ueseless whitespaces at the end of each line. See
-- https://vim.fandom.com/wiki/Remove_unwanted_spaces
--]]
vim.api.nvim_create_autocmd({'BufWritePre'}, {
  pattern = '*',
  command = ':%s/\\s\\+$//e';
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


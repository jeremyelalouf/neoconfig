-- Plugins
--[[
-- From https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom for vim
-- plug usage in lua.
--]]

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugins')

Plug('nvim-telescope/telescope.nvim')
Plug('nvim-telescope/telescope-fzy-native.nvim')
Plug('dhananjaylatkar/cscope_maps.nvim')

Plug('tpope/vim-fugitive')
Plug('preservim/nerdcommenter')

Plug('neovim/nvim-lspconfig')

Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-vsnip')
Plug('hrsh7th/vim-vsnip')

Plug('github/copilot.vim')

Plug 'MunifTanjim/nui.nvim'
Plug('nvim-lua/plenary.nvim')
Plug('nvim-tree/nvim-web-devicons')
Plug('nvim-neo-tree/neo-tree.nvim')

Plug('altercation/vim-colors-solarized')
vim.call('plug#end')

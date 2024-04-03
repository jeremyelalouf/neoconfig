-- Plugins
--[[
-- From https://dev.to/vonheikemen/neovim-using-vim-plug-in-lua-3oom for vim
-- plug usage in lua.
--]]

return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Theme
    -- use {'morhetz/gruvbox'}
    -- use {'maxmx03/solarized.nvim'}
    -- use {'shaunsingh/solarized.nvim'}
    use {'altercation/vim-colors-solarized'}
    use 'luochen1990/rainbow'
    use 'kyazdani42/nvim-web-devicons'
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'mfussenegger/nvim-dap' -- Debugging

    -- Completion and snippets
    use { 'ray-x/lsp_signature.nvim', commit = "1d96fac72eb6d74abd5b4d7883a01f58aeb4f87e" }
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- File search and navigation
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.5',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons',
      },
    }

    -- Others
    use 'tpope/vim-fugitive'
    use { 'nvim-treesitter/nvim-treesitter', tag = 'v0.8.1' }

    -- Writing and editing
    use {'numToStr/Comment.nvim'}
    -- use 'preservim/nerdcommenter'
end)

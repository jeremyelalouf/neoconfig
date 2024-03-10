-- Theme

-- vim.api.nvim_set_option('background', 'dark')
-- vim.api.nvim_command('set termguicolors')

-- require("catppuccin").setup({
--   flavour = "mocha", -- latte, frappe, macchiato, mocha
--   transparent_background = true, -- disables setting the background color.
-- })

-- vim.api.nvim_command('colorscheme catppuccin')
vim.api.nvim_set_option('background', 'dark')
vim.api.nvim_command('let g:solarized_termcolors=256')
vim.api.nvim_command('let g:solarized_termtrans=1')
vim.api.nvim_command('let g:solarized_contrast="normal"')
vim.api.nvim_command('let g:solarized_visibility="normal"')
vim.api.nvim_command('colorscheme solarized')
-- vim.api.nvim_command('highlight! Function ctermfg=33 guifg=#40ffff')
vim.api.nvim_command('highlight clear Identifier')

require('lualine').setup{
  -- options = {
  --   theme = ''
  -- },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {
      'filename',
      function()
        return vim.fn['nvim_treesitter#statusline'](180)
      end},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
}

-- LSP

require'lspconfig'.rust_analyzer.setup{
  settings = {
    ['rust-analyzer'] = {
        procMacro = {
            enable = true
        }
    }
  }
}

-- Completion and snippets

require "lsp_signature".setup({
  hint_prefix = "",
  floating_window = true,
  bind = true,
})

-- File search and navigation

local telescope = require'telescope'
local builtin = require('telescope.builtin')

-- telescope.load_extension('fzy_native') do i need this ?

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {noremap = true, silent = true})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')

  vim.keymap.set('n', '<C-e>', api.tree.toggle, {noremap = true, silent = true})
  vim.keymap.set('n', '<CR>', api.node.open.edit)
  vim.keymap.set('n', 'a', api.fs.create)
  vim.keymap.set('n', 'd', api.fs.remove)
  vim.keymap.set('n', 'r', api.fs.rename)
end

require("nvim-tree").setup({
  on_attach = my_on_attach,
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
})

-- Others

vim.api.nvim_set_keymap('n', '<leader>gt', ':Git difftool<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gs', ':Git status<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gd', ':Git diff<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gc', ':Git commit<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gb', ':Git blame<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gl', ':Git log<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gp', ':Git push<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gr', ':Gread<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gw', ':Gwrite<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ge', ':Gedit<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gi', ':Git add -p %<CR>', {noremap = true, silent = true})

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
  },
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua","typescript", "cpp", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}




-- require('nvim-treesitter.configs').setup {
--   -- A list of parser names, or "all" (the five listed parsers should always be installed)
--   ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "typescript" },

--   -- Install parsers synchronously (only applied to `ensure_installed`)
--   sync_install = false,

--   -- Automatically install missing parsers when entering buffer
--   -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
--   auto_install = true,

--   -- List of parsers to ignore installing (or "all")
--   ignore_install = { "javascript" },

--   ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
--   -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

--   highlight = {
--     enable = true,

--     -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
--     -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
--     -- the name of the parser)
--     -- list of language that will be disabled
--     -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
--     disable = function(lang, buf)
--         local max_filesize = 100 * 1024 -- 100 KB
--         local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--         if ok and stats and stats.size > max_filesize then
--             return true
--         end
--     end,

--     -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
--     -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
--     -- Using this option may slow down your editor, and you may see some duplicate highlights.
--     -- Instead of true it can also be a list of languages
--     additional_vim_regex_highlighting = false,
--   },
-- }

-- -- ToggleTerm config

-- require("toggleterm").setup()

-- function _G.set_terminal_keymaps()
--   local opts = {buffer = 0}
--   vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
--   vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
--   vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
--   vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
--   vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
--   vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
--   vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
-- end

-- vim.keymap.set('n', '<leader>ot', ':ToggleTerm direction=float<CR>', {})

-- -- if you only want these mappings for toggle term use term://*toggleterm#* instead
-- vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- -- Epitech header config
-- local epiheader = require 'epitech-header'
-- vim.keymap.set("n", "<leader>ep", ":InsertHeader<CR>")

-- -- Cscope config

-- local cscope = require'cscope'


-- cscope.setup({
--   disable_maps = true,
--   cscope = {
--     picker = "telescope",
--     skip_picker_for_single_result = true
--   }
-- })

-- -- Find assignments to this symbol
-- vim.api.nvim_set_keymap('n', '<leader>sa', ':Cscope find a <C-R><C-W><CR>', {noremap = true, silent = true})

-- -- Find functions calling this function
-- vim.api.nvim_set_keymap('n', '<leader>sc', ':Cscope find c <C-R><C-W><CR>', {noremap = true, silent = true})

-- -- Find functions called by this function
-- vim.api.nvim_set_keymap('n', '<leader>sd', ':Cscope find d <C-R><C-W><CR>', {noremap = true, silent = true})

-- -- Find this egrep pattern
-- vim.api.nvim_set_keymap('n', '<leader>se', ':Cscope find e <C-R><C-W><CR>', {noremap = true, silent = true})

-- -- Find this file
-- vim.api.nvim_set_keymap('n', '<leader>sf', ':Cscope find f <C-R><C-W><CR>', {noremap = true, silent = true})

-- -- Find this definition
-- vim.api.nvim_set_keymap('n', '<leader>sg', ':Cscope find g <C-R><C-W><CR>', {noremap = true, silent = true})

-- -- Find files #including this file
-- vim.api.nvim_set_keymap('n', '<leader>si', ':Cscope find i <C-R><C-W><CR>', {noremap = true, silent = true})

-- -- Find this C symbol
-- vim.api.nvim_set_keymap('n', '<leader>ss', ':Cscope find s <C-R><C-W><CR>', {noremap = true, silent = true})

-- -- Find this text string
-- vim.api.nvim_set_keymap('n', '<leader>st', ':Cscope find t <C-R><C-W><CR>', {noremap = true, silent = true})

-- -- Neotree config

-- local neo_tree = require'neo-tree'

-- require'nvim-web-devicons'.setup {
--  -- your personnal icons can go here (to override)
--  -- you can specify color or cterm_color instead of specifying both of them
--  -- DevIcon will be appended to `name`
--  -- globally enable different highlight colors per icon (default to true)
--  -- if set to false all icons will have the default icon's color
--  color_icons = true;
--  -- globally enable default icons (default to false)
--  -- will get overriden by `get_icons` option
--  default = true;
--  -- globally enable "strict" selection of icons - icon will be looked up in
--  -- different tables, first by filename, and if not found by extension; this
--  -- prevents cases when file doesn't have any extension but still gets some icon
--  -- because its name happened to match some extension (default to false)
--  strict = true;
--  -- same as `override` but specifically for overrides by filename
--  -- takes effect when `strict` is true
--  override_by_filename = {
--   [".gitignore"] = {
--     icon = "",
--     color = "#f1502f",
--     name = "Gitignore"
--   }
--  };
--  -- same as `override` but specifically for overrides by extension
--  -- takes effect when `strict` is true
--  override_by_extension = {
--   ["log"] = {
--     icon = "",
--     color = "#81e043",
--     name = "Log"
--   }
--  };
-- }

-- neo_tree.setup({
--   requires = "nvim-tree/nvim-web-devicons",
--   event_handlers = {{
--     event = "file_opened",
--     handler = function(_)
--     require("neo-tree.command").execute({ action = "close" })
--     end
--   },},
--   window = {
--     mappings = {
--       ['u'] = 'navigate_up',
--     }
--   }
-- })


-- -- Fugitive config

-- vim.api.nvim_set_keymap('n', '<leader>gt', ':Git difftool<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>gs', ':Git status<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>gd', ':Git diff<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>gc', ':Git commit<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>gb', ':Git blame<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>gl', ':Git log<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>gp', ':Git push<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>gr', ':Gread<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>gw', ':Gwrite<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>ge', ':Gedit<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<leader>gi', ':Git add -p %<CR>', {noremap = true, silent = true})

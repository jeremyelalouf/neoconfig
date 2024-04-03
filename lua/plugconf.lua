-- Theme

vim.o.background = 'dark'

vim.api.nvim_command('let g:solarized_termcolors=256')
vim.api.nvim_command('let g:solarized_termtrans=1')
vim.api.nvim_command('let g:solarized_contrast="normal"')
vim.api.nvim_command('let g:solarized_visibility="normal"')

vim.api.nvim_command('colorscheme solarized')

vim.api.nvim_command('highlight clear SignColumn')
vim.api.nvim_command('highlight clear LineNr')

require('lualine').setup {
    options = {
        theme = 'solarized',
        disabled_filetypes = {
            'NvimTree',
        },
    },
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

require'lspconfig'.clangd.setup{
    capabilities = {
        offsetEncoding = { "utf-16" }
    }
}

local dap = require('dap')

dap.adapters.lldb = {
  type = 'executable',
  command = 'lldb-vscode',
  name = 'lldb'
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}

-- same config for C
dap.configurations.c = dap.configurations.cpp

-- Completion and snippets

require "lsp_signature".setup({
  hint_prefix = "",
  floating_window = false,
  bind = true,
})

-- File search and navigation

local telescope = require'telescope'
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {noremap = true, silent = true})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set('n', '<C-e>', api.tree.toggle, opts("toggle"))
end

vim.api.nvim_set_keymap('n', '<C-e>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

require("nvim-tree").setup({
    on_attach = my_on_attach,
    view = {
        width = 40,
    },
    update_focused_file = {
	    enable = true,
    }
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
  ensure_installed = { "c", "lua","typescript", "cpp", "rust" },

  sync_install = false,

  auto_install = true,

  ignore_install = { "javascript" },


  highlight = {
    enable = true,

    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    additional_vim_regex_highlighting = false,
  },
}

require'nvim-web-devicons'.setup {
  default = true;
  color_icons = true;
}

-- Writing and editing

local commentApi = require('Comment.api')
local esc = vim.api.nvim_replace_termcodes(
            '<ESC>', true, false, true
)

vim.keymap.set('n', '<leader>c<SPACE>', commentApi.toggle.linewise.current)

vim.keymap.set('x', '<leader>c<SPACE>', function()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    commentApi.toggle.linewise(vim.fn.visualmode())
end)

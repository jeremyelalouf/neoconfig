-- Telescope config

local telescope = require'telescope'
local builtin = require('telescope.builtin')

telescope.setup()
telescope.load_extension('fzy_native')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Cscope config

local cscope = require'cscope'


cscope.setup({
  disable_maps = true,
  cscope = {
    picker = "telescope",
    skip_picker_for_single_result = true
  }
})


-- Neotree config

local neo_tree = require'neo-tree'

neo_tree.setup({
  event_handlers = {{
    event = "file_opened",
    handler = function(_)
    require("neo-tree.command").execute({ action = "close" })
    end
  },},
  window = {
    mappings = {
      ['u'] = 'navigate_up',
    }
  }
})

vim.api.nvim_set_keymap('n', '<C-e>', ':Neotree toggle reveal<CR>', {noremap = true, silent = true})

-- Fugitive config

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

local which_key = require('which-key')
local telescope = require('telescope.builtin')

local mappings = {
    { '<Tab>', ':tabnext<CR>', desc='Next Tab', mode='n', },
    { '<S-Tab>', ':tabprev<CR>', desc='Previous Tab', mode='n' },
    { '<leader>/', 'gc', desc='Toggle Comment', mode='v', remap=true, },
    { '<leader>/', 'gcc', desc='Toggle Comment', mode='n', remap=true, },
    { '<leader>ff', telescope.find_files, desc='Find Files', mode='n', },
    { '<leader>fg', telescope.live_grep, desc='Find Files', mode='n', },
    { '<leader><leader>n', vim.diagnostic.goto_next, desc='Next Diagnostic', mode='n', },
    { '<leader><leader>p', vim.diagnostic.goto_prev, desc='Previous Diagnostic', mode='n', },
    { '<leader><leader>d', telescope.diagnostics, desc='List Diagnostics', mode='n', },

--     vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
  -- J = { 'mzJ`z', 'Join lines and keep cursor position' },
  -- ['<C-d>'] = { '<C-d>zz', 'Half page down and center' },
  -- ['<C-u>'] = { '<C-u>zz', 'Half page up and center' },
  -- n = { 'nzzzv', 'Next search result and center' },
  -- N = { 'Nzzzv', 'Previous search result and center' },
  -- Q = { '<nop>', 'Disable Ex mode' },
}

which_key.add(mappings)

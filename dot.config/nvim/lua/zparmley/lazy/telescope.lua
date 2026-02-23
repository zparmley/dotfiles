return {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- native extension, fzf
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    }
}

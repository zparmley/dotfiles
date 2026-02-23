return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.config")

    configs.setup({
      ensure_installed = {
        'c', 'lua', 'vim', 'vimdoc', 'elixir', 'javascript', 'html', 'python', 'typescript', 'help'
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}

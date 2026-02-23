local function open_unfocused_tab(node)
    local api = require 'nvim-tree.api'
    api.node.open.tab(node, { focus = false })
end


-- https://github.com/nvim-tree/nvim-tree.lua/tree/v1.15.0?tab=readme-ov-file#custom-mappings
local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        local ret = {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
        }

        return ret
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)
    -- api.map.on_attach.default.on_attach_default(bufnr)

    -- custom mappings
    vim.keymap.set('n', 't', api.node.open.tab_drop, opts('Switch to or Open in tab'))
    vim.keymap.set('n', '<S-t>', open_unfocused_tab, opts('Open in new background tab'))
    vim.keymap.set('n', '<Tab>', ':tabnext<CR>', opts('Next Tab'))
end

return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup(
            {
                on_attach = my_on_attach,
                filters = {
                    dotfiles = false,
                    git_ignored = false
                }
            }
        )
    end
}

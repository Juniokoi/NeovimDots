vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require'nvim-tree'.setup {
    hijack_cursor = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    renderer = {
        add_trailing = true,
        indent_width = 1,
        root_folder_modifier = ":t",
        indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
                corner = "└",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " ",
            },
        },
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "U",
                    deleted = "",
                    ignored = "◌",
                },
            },
        },
    },
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    git = {
        enable = false,
    },
    diagnostics = {
        enable = true,
        show_on_dirs = false,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    view = {
        width = 30,
        side = "left",
        signcolumn = "yes",
        adaptive_size = true,
        mappings = {
            list = {
                { key = { "l", "<CR>", "o" }, cb = "edit" },
                { key = "h", cb = "close_node" },
                { key = "v", cb = "vsplit" },
                { key = "<Esc>", cb = "close" },
            },
        },
        float = {
            enable = false,
            quit_on_focus_loss = false,
            open_win_config = {
                relative = "win",
                border = "rounded",
                anchor = "NW",
                width = 30,
                height = 20,
                row = 1,
                col = 300,
            },
        },
    }
}

require('rose-pine').setup({
    highlight_groups = {
        IndentBlanklineIndent1 = { fg = "subtle", bg = "NONE" },
        IndentBlanklineIndent2 = { fg = "subtle", bg = "NONE" },
        IndentBlanklineIndent3 = { fg = "#280034", bg = "NONE" },
        IndentBlanklineIndent4 = { fg = "#282C00", bg = "NONE" },
        IndentBlanklineIndent5 = { fg = "#200C34", bg = "NONE" },
        IndentBlanklineIndent6 = { fg = "#082034", bg = "NONE" },
        IndentBlanklineContextChar = { fg = "#00ff00" },

        ContextBlanklineIndent1 = { fg = 'iris', bg = "NONE" },
        ContextBlanklineIndent2 = { fg = "foam", bg = "NONE" },
        ContextBlanklineIndent3 = { fg = "rose", bg = "NONE" },
        ContextBlanklineIndent4 = { fg = "gold", bg = "NONE" },
        ContextBlanklineIndent5  = { fg = "pine", bg = "NONE" },
        ContextBlanklineIndent6 = { fg = "foam", bg = "NONE" },
    }
})

vim.cmd("colorscheme rose-pine")

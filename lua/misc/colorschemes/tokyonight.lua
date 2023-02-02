local tokyo = require("tokyonight")

tokyo.setup {
  style = "night",
  comments = { italic = true },
  transparent = true,
  on_highlights = function(hl, c)
    hl.IndentBlanklineIndent1 = { fg = "#282C34", bg = "NONE" }
    hl.IndentBlanklineIndent2 = { fg = "#002C34", bg = "NONE" }
    hl.IndentBlanklineIndent3= { fg = "#280034", bg = "NONE" }
    hl.IndentBlanklineIndent4= { fg = "#282C00", bg = "NONE" }
    hl.IndentBlanklineIndent5= { fg = "#200C34", bg = "NONE" }
    hl.IndentBlanklineIndent6= { fg = "#082034", bg = "NONE" }

    hl.ContextBlanklineIndent1= { fg = "#ff0000" }
    hl.ContextBlanklineIndent2= { fg = "#00ff00" }
    hl.ContextBlanklineIndent3= { fg = "#2800ff" }
    hl.ContextBlanklineIndent4= { fg = "#ff0000" }
    hl.ContextBlanklineIndent5= { fg = "#20ff34" }
    hl.ContextBlanklineIndent6= { fg = "#0820ff" }
  end
}

return vim.cmd("colorscheme tokyonight")

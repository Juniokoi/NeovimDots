local themes = {}

function themes.kanagawa()
    require("misc.colorschemes.kanagawa")
end

function themes.tokyonight()
    require("misc.colorschemes.tokyonight")
end

function themes.rosepine()
    require("misc.colorschemes.rosepine")
end

function themes.set_theme(theme)
    if themes[theme] then
        themes[theme]()
    else
        print("Theme not found")
    end
end

return themes


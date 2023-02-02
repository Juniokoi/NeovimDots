local config = {}

function config.telescope()
    require"modules.utils.telescope"
end

function config.nvimtree()
    require"modules.utils.nvimtree"
end

function config.toggleterm()
    require"modules.utils.toggleterm"
end

return config

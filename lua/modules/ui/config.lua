local config = {}

function config.animate()
	-- No need to copy this inside `setup()`. Will be used automatically.
	local animate = require('mini.animate')
	animate.setup {
		-- Cursor path
		animations = {
			{
				trigger = { "BufRead", "BufNewFile" },
				anim = {
					{ "mini", "fadeIn" },
					{ "mini", "slideInRight" },
				},
			},
			{
				trigger = { "BufLeave" },
				anim = {
					{ "mini", "fadeOut" },
					{ "mini", "slideOutRight" },
				},
			},
		},
		cursor = {
			-- Whether to enable this animation
			enable = true,
			timing = animate.gen_timing.linear({ easing = "in-out", duration = 10, unit = 'total' }),
			path = animate.gen_path.line({
				predicate = function() return true end,
			}),
		},

		-- Vertical scroll
		scroll = {
			enable = false,
		},

		-- Window resize
		resize = {
			enable = false,
		},

		-- Window open
		open = {
			enable = false,
		},

		-- Window close
		close = {
			-- Whether to enable this animation
			enable = false,
		}
	}
end

function config.alpha()
	require("modules.ui.dashboard")
end

return config

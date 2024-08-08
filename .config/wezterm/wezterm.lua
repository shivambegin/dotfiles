-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha"
-- config.color_scheme = "Rosé Pine (Gogh)"
-- config.color_scheme = "Poimandres"

config.color_schemes = {
	["Catppuccin Mocha"] = {
		background = "#11111B", -- to match neovim ayu theme
	},
}
local opacity = 0.95

--fonts

config.font = wezterm.font_with_fallback({
	-- { family = "FiraCode Nerd Font Mono" },
	-- { family = "Maple Mono" },
	-- { family = "Iosevkaterm Nerd Font" },
	-- { family = "FantasqueSansM Nerd Font" },
	-- { family = "Iosevka Nerd Font" },
	{ family = "SpaceMono Nerd Font Mono" },
	{ family = "JetBrains Mono" },
	{ family = "Symbols Nerd Font Mono" },
})

-- config.line_height = 1.3
config.font_size = 18
config.term = "wezterm"
config.underline_position = -5
config.window_close_confirmation = "NeverPrompt"
config.max_fps = 144
config.animation_fps = 60
config.scrollback_lines = 10000
-- add window size initial coll and row
config.initial_cols = 120
config.initial_rows = 25
config.window_background_opacity = opacity
config.adjust_window_size_when_changing_font_size = false
config.window_decorations = "RESIZE"
config.disable_default_key_bindings = false

-- config.window_padding = {
-- 	left = 10,
-- 	right = 10,
-- 	top = 10,
-- 	bottom = 0,
-- }

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.inactive_pane_hsb = {
	saturation = 1.0,
	brightness = 1.0,
}

if os.getenv("XDG_CURRENT_DESKTOP") == "Hyprland" then
	config.enable_wayland = false
else
	config.enable_wayland = true
end

--keybindings like tmux

config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

-- Tab bar
wezterm.on("toggle-tabbar", function(window, _)
	local overrides = window:get_config_overrides() or {}
	if overrides.enable_tab_bar == false then
		wezterm.log_info("tab bar shown")
		overrides.enable_tab_bar = true
	else
		wezterm.log_info("tab bar hidden")
		overrides.enable_tab_bar = false
	end
	window:set_config_overrides(overrides)
end)
-- I don't like the look of "fancy" tab bar
config.enable_tab_bar = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.status_update_interval = 1000
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 999999
config.show_tab_index_in_tab_bar = true
config.show_tabs_in_tab_bar = true
config.switch_to_last_active_tab_when_closing_tab = true
config.show_new_tab_button_in_tab_bar = true
config.colors = {
	tab_bar = {
		background = "rgba(0, 0, 0, 0)",
	},
}
return config

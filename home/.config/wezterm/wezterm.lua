local wt = require("wezterm")
local config = wt.config_builder()

-----------------------------
--   Colors & Appearance   --
-----------------------------

local font = wt.font
local mux = wt.mux

-- Colors
config.color_scheme = "Kanagawa Dragon (Gogh)"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20

-- Font
config.font = font("FiraCode Nerd Font Mono")
config.font_size = 19.

-- Window / Tab bar
config.window_padding = {
	left = "1cell",
	right = "1cell",
	top = "0.2cell",
	bottom = "0.2cell",
}
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

wt.on("update-right-status", function(window, _)
	local prefix = window:leader_is_active() and "$W" or "$"
	local ws = mux.get_active_workspace()

	window:set_left_status(wt.format({
		{ Text = " " .. prefix .. " " },
	}))

	window:set_right_status(wt.format({
		{ Text = "(" .. ws .. ") " },
	}))
end)

-- Cursor
config.cursor_blink_rate = 800

-----------------------------
--           MUX           --
-----------------------------

config.unix_domains = {
	{ name = "unix" },
}

-----------------------------
--         Keymaps         --
-----------------------------

local act = wt.action

config.leader = { key = "t", mods = "ALT", timeout_milliseconds = 1000 }

config.keys = {
	-- MUX commands
	----  Tabs
	{
		key = "v",
		mods = "LEADER",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "c",
		mods = "LEADER",
		action = act.SpawnCommandInNewTab({
			cwd = wt.home_dir,
		}),
	},
	{
		key = "x",
		mods = "LEADER",
		action = act.CloseCurrentTab({ confirm = false }),
	},
	{
		mods = "ALT",
		key = "h",
		action = act.ActivateTabRelative(-1),
	},
	{
		mods = "ALT",
		key = "l",
		action = act.ActivateTabRelative(1),
	},
	{
		key = ",",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wt.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	---- Workspaces
	{
		key = "s",
		mods = "LEADER",
		action = act.ShowLauncherArgs({
			flags = "FUZZY|WORKSPACES",
		}),
	},
	{
		key = "$",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new name for workspace",
			action = wt.action_callback(function(_, _, line)
				if line then
					local ws = mux.get_active_workspace()
					mux.rename_workspace(ws, line)
				end
			end),
		}),
	},
}

for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "ALT",
		action = act.ActivateTab(i - 1),
	})
end

-----------------------------
--         Behavior        --
-----------------------------

-- Window
config.window_close_confirmation = "NeverPrompt"
config.front_end = "WebGpu"

-----------------------------
--         Startup         --
-----------------------------

-- Mux
config.default_gui_startup_args = { "connect", "unix" }

return config

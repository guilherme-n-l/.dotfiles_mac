local hs = hs
local bind = hs.hotkey.bind

local function exec(cmd) hs.execute(cmd, true) end

-----------------
--    Yabai    --
-----------------

bind("alt", "r", function()
	exec("yabai --restart-service")
end)

-- Windows

local dirs = {
	{ key = "h", direction = "west" },
	{ key = "j", direction = "south" },
	{ key = "k", direction = "north" },
	{ key = "l", direction = "east" },
}

local modes = {
	{ key = "f", mode = "float" },
	{ key = "m", mode = "zoom-fullscreen" },
	{ key = "e", mode = "split" },
}

--  Focus
for _, dir in ipairs(dirs) do
    bind("alt", dir.key, function()
        exec("yabai -m window --focus " .. dir.direction)
    end)
end

--  Swap
for _, dir in ipairs(dirs) do
    bind({"alt", "shift"}, dir.key, function()
        exec("yabai -m window --swap" .. dir.direction)
    end)
end

--  Resize
dirs = {
	{ key = "h", direction = "left:-20:0" },
	{ key = "j", direction = "top:0:+20" },
	{ key = "k", direction = "top:0:-20" },
	{ key = "l", direction = "left:+20:0" },
}

for _, dir in ipairs(dirs) do
    bind({"alt", "ctrl"}, dir.key, function()
        exec("yabai -m window --resize" .. dir.direction)
    end)
end

bind({"alt", "ctrl"}, "0", function()
    exec("yabai -m space --balance")
end)

--  Modes
for _, mod in ipairs(modes) do
    bind({"alt", "ctrl"}, mod.key, function()
        exec("yabai -m window --toggle" .. mod.mode)
    end)
end

-----------------
--     Apps    --
-----------------

-- Launcher
bind("alt", "space", function()
    exec("bash ~/.config/skhd/launcher.sh")
end)

-- Terminal

bind({"alt", "cmd"}, "t", function()
    exec("alacritty -e bash -c 'tmux attach || tmux'")
end)

bind({"alt", "shift", "cmd"}, "t", function()
    exec("alacritty -e bash -c 'tmux'")
end)

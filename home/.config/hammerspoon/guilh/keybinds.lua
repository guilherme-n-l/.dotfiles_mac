local wm = require("guilh.wm")

local hs = hs

hs.hotkey.bind({ "ctrl", "shift" }, "t", function()
    hs.execute("open -n /Applications/ghostty.app")
end)

hs.hotkey.bind("ctrl", "e", function()
    hs.execute("open ~")
end)

hs.hotkey.bind("ctrl", ".", function()
	wm.sw:next()
end)
hs.hotkey.bind("ctrl", ",", function()
	wm.sw:previous()
end)

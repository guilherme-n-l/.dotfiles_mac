local hs = hs
local sw = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter({}))

sw.ui.showThumbnails = false
sw.ui.showTitles = false
sw.ui.showSelectedThumbnail = false
sw.ui.showSelectedTitle = false
sw.ui.showExtraKeys = false

sw.ui.backgroundColor = { 0, 0, 0, 0.5 }
sw.ui.highlightColor = { 0, 0, 0, 0.6 }
sw.ui.showIcons = false

hs.hotkey.bind("ctrl", ".", function()
	sw:next()
end)
hs.hotkey.bind("ctrl", ",", function()
	sw:previous()
end)

hs.hotkey.bind({ "ctrl", "shift" }, "t", function()
    hs.execute("open -n /Applications/ghostty.app")
end)

sw = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter({}))

sw.ui.showThumbnails = false
sw.ui.showTitles = false
sw.ui.showSelectedThumbnail = false
sw.ui.showSelectedTitle = false
sw.ui.showExtraKeys = false

sw.ui.backgroundColor = { 0, 0, 0, 0.5 }
sw.ui.highlightColor = { 0, 0, 0, 0.6 }
sw.ui.showIcons = false

return {
    sw = sw
}

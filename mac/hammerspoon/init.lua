-- require "vim"

-- local ctrlshift = {"ctrl", "shift"}
-- hs.hotkey.bind(ctrlshift, "up", hs.window.focusWindowNorth)
-- hs.hotkey.bind(ctrlshift, "right", hs.window.focusWindowEast)
-- hs.hotkey.bind(ctrlshift, "down", hs.window.focusWindowSouth)
-- hs.hotkey.bind(ctrlshift, "q", hs.window.focusWindowWest)


-- ctrl+g sends ctrl
hs.hotkey.bind({"ctrl"}, "q", function()
    hs.eventtap.keyStroke({}, "Return")
end)

hs.hotkey.bind({"cmd", "ctrl"}, "R", function()
  hs.reload()
end)

hs.alert.show("Config loaded")

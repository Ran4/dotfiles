-- ctrl+g sends ctrl
hs.hotkey.bind({"ctrl"}, "g", function()
    hs.eventtap.keyStroke({}, "Return")
end)

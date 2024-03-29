-- Vim style modal bindings
-- Most of the code is from https://github.com/dbmrq/dotfiles/blob/master/home/.hammerspoon/vim.lua
-- Normal mode {{{1
local normal = hs.hotkey.modal.new()

-- <c-c> - enter Normal mode
-- I don't remap <esc> because it's too risky
-- enterNormal = hs.hotkey.bind({"ctrl"}, "[", function()
-- enterNormal = hs.hotkey.bind({"ctrl"}, "q", function()
--     normal:enter()
--     hs.alert.show('Normal mode')
-- end)

-- Movements {{{2
-- h - move left
function left() hs.eventtap.keyStroke({}, "Left") end
normal:bind({}, 'h', left, nil, left)

-- l - move right
function right() hs.eventtap.keyStroke({}, "Right") end
normal:bind({}, 'l', right, nil, right)

-- k - move up
function up() hs.eventtap.keyStroke({}, "Up") end
normal:bind({}, 'k', up, nil, up)

-- j - move down
function down() hs.eventtap.keyStroke({}, "Down") end
normal:bind({}, 'j', down, nil, down)

-- w - move to next word
function word() hs.eventtap.keyStroke({"alt"}, "Right") end
normal:bind({}, 'w', word, nil, word)
normal:bind({}, 'e', word, nil, word)

-- b - move to previous word
function back() hs.eventtap.keyStroke({"alt"}, "Left") end
normal:bind({}, 'b', back, nil, back)

-- 0 - move to beginning of line
normal:bind({}, '0', function()
    hs.eventtap.keyStroke({"cmd"}, "Left")
end)

-- $, € - move to end of line
normal:bind({"alt"}, '4', function()
    hs.eventtap.keyStroke({"cmd"}, "Right")
end)

normal:bind({"shift"}, '4', function()
    hs.eventtap.keyStroke({"cmd"}, "Right")
end)

-- g - move to beginning of text
normal:bind({}, 'g', function()
    hs.eventtap.keyStroke({"cmd"}, "Up")
end)

-- G - move to end of text
normal:bind({"shift"}, 'g', function()
    hs.eventtap.keyStroke({"cmd"}, "Down")
end)

-- z - center cursor
normal:bind({}, 'z', function()
    hs.eventtap.keyStroke({"ctrl"}, "L")
end)

-- <c-f> - page down
normal:bind({"ctrl"}, "f", function()
    hs.eventtap.keyStroke({}, "pagedown")
end)

-- <c-b> - page up
normal:bind({"ctrl"}, "b", function()
    hs.eventtap.keyStroke({}, "pageup")
end)
-- -- }}}2
-- -- Insert {{{2
-- i - insert at cursor
normal:bind({}, 'i', function()
    normal:exit()
    hs.alert.show('Insert mode')
end)

-- I - insert at beggining of line
normal:bind({"shift"}, 'i', function()
    hs.eventtap.keyStroke({"cmd"}, "Left")
    normal:exit()
    hs.alert.show('Insert mode')
end)

-- a - append after cursor
normal:bind({}, 'a', function()
    hs.eventtap.keyStroke({}, "Right")
    normal:exit()
    hs.alert.show('Insert mode')
end)

-- A - append to end of line
normal:bind({"shift"}, 'a', function()
    hs.eventtap.keyStroke({"cmd"}, "Right")
    normal:exit()
    hs.alert.show('Insert mode')
end)

-- o - open new line below cursor
normal:bind({}, 'o', nil, function()
    local app = hs.application.frontmostApplication()
    if app:name() == "Finder" then
        hs.eventtap.keyStroke({"cmd"}, "o")
    else
        hs.eventtap.keyStroke({"cmd"}, "Right")
        normal:exit()
        hs.eventtap.keyStroke({}, "Return")
        hs.alert.show('Insert mode')
    end
end)

-- O - open new line above cursor
normal:bind({"shift"}, 'o', nil, function()
    local app = hs.application.frontmostApplication()
    if app:name() == "Finder" then
        hs.eventtap.keyStroke({"cmd", "shift"}, "o")
    else
        hs.eventtap.keyStroke({"cmd"}, "Left")
        normal:exit()
        hs.eventtap.keyStroke({}, "Return")
        hs.eventtap.keyStroke({}, "Up")
        hs.alert.show('Insert mode')
    end
end)
-- -- }}}2

-- Delete {{{2
-- d - delete word
local function delete()
    --hs.eventtap.keyStroke({}, "delete") --delete char before cursor
    hs.eventtap.keyStroke({"alt", "shift"}, "right")
    hs.eventtap.keyStroke({}, "delete")
end
normal:bind({}, 'd', delete, nil, delete)

-- x - delete character after the cursor
local function fndelete()
    hs.eventtap.keyStroke({}, "Right")
    hs.eventtap.keyStroke({}, "delete")
end
normal:bind({}, 'x', fndelete, nil, fndelete)

-- D - delete until end of line
normal:bind({"shift"}, 'D', nil, function()
    normal:exit()
    hs.eventtap.keyStroke({"ctrl"}, "k")
    normal:enter()
end)

-- -- }}}2



-- -- : - in Safari, focus address bar; everywhere else, call Alfred {{{2
-- normal:bind({"shift"}, ';', function()
--     local app = hs.application.frontmostApplication()
--     if app:name() == "Safari" then
--         hs.eventtap.keyStroke({"cmd"}, "l") -- go to address bar
--     else
--         hs.eventtap.keyStroke({"ctrl"}, "space") -- call Alfred
--     end
-- end)
-- -- }}}2


normal:bind({}, 's', function()
    normal:exit()
    hs.alert.show('Insert mode')
    fndelete()
end)

-- c - change word
local function changeword()
    --hs.eventtap.keyStroke({}, "delete") --delete char before cursor
    normal:exit()
    hs.alert.show('Insert mode')
    hs.eventtap.keyStroke({"alt", "shift"}, "right")
    hs.eventtap.keyStroke({}, "delete")
end
normal:bind({}, 'c', changeword, nil, changeword)
-- }}}2

-- / - - search {{{2
normal:bind({"shift"}, '7', function()
    hs.eventtap.keyStroke({"cmd"}, "f")
end)

normal:bind({}, '-', function()
    hs.eventtap.keyStroke({"cmd"}, "f")
end)
-- }}}2

-- u - undo {{{2
normal:bind({}, 'u', function()
    hs.eventtap.keyStroke({"cmd"}, "z")
end)
-- }}}2

-- <c-r> - redo {{{2
normal:bind({"ctrl"}, 'r', function()
    hs.eventtap.keyStroke({"cmd", "shift"}, "z")
end)
-- }}}2

-- y - yank {{{2
normal:bind({}, 'y', function()
    hs.eventtap.keyStroke({"cmd"}, "c")
end)
-- }}}2

-- p - paste {{{2
normal:bind({}, 'p', function()
    hs.eventtap.keyStroke({"cmd"}, "v")
end)
-- }}}2

-- -- }}}1

-- -- Visual mode {{{1

-- local visual = hs.hotkey.modal.new()

-- -- v - enter Visual mode {{{2
-- normal:bind({}, 'v', function() normal:exit() visual:enter() end)
-- function visual:entered() hs.alert.show('Visual mode') end
-- -- }}}2

-- -- <c-c> - exit Visual mode {{{2
-- visual:bind({"ctrl"}, 'c', function()
--     visual:exit()
--     normal:exit()
--     hs.eventtap.keyStroke({}, "Right")
--     hs.alert.show('Normal mode')
-- end)
-- -- }}}2

-- -- Movements {{{2

-- -- h - move left
-- function vleft() hs.eventtap.keyStroke({"shift"}, "Left") end
-- visual:bind({}, 'h', vleft, nil, vleft)

-- -- l - move right
-- function vright() hs.eventtap.keyStroke({"shift"}, "Right") end
-- visual:bind({}, 'l', vright, nil, vright)

-- -- k - move up
-- function vup() hs.eventtap.keyStroke({"shift"}, "Up") end
-- visual:bind({}, 'k', vup, nil, vup)

-- -- j - move down
-- function vdown() hs.eventtap.keyStroke({"shift"}, "Down") end
-- visual:bind({}, 'j', vdown, nil, vdown)

-- -- w - move to next word
-- function word() hs.eventtap.keyStroke({"alt", "shift"}, "Right") end
-- visual:bind({}, 'w', word, nil, word)
-- visual:bind({}, 'e', word, nil, word)

-- -- b - move to previous word
-- function back() hs.eventtap.keyStroke({"alt", "shift"}, "Left") end
-- visual:bind({}, 'b', back, nil, back)

-- -- 0, H - move to beginning of line
-- visual:bind({}, '0', function()
--     hs.eventtap.keyStroke({"cmd", "shift"}, "Left")
-- end)

-- visual:bind({"shift"}, 'h', function()
--     hs.eventtap.keyStroke({"cmd", "shift"}, "Left")
-- end)

-- -- $, L - move to end of line
-- visual:bind({"shift"}, '4', function()
--     hs.eventtap.keyStroke({"cmd", "shift"}, "Right")
-- end)

-- visual:bind({"shift"}, 'l', function()
--     hs.eventtap.keyStroke({"cmd", "shift"}, "Right")
-- end)

-- -- g - move to beginning of text
-- visual:bind({}, 'g', function()
--     hs.eventtap.keyStroke({"shift", "cmd"}, "Up")
-- end)

-- -- G - move to end of text
-- visual:bind({"shift"}, 'g', function()
--     hs.eventtap.keyStroke({"shift", "cmd"}, "Down")
-- end)

-- -- }}}2

-- -- d, x - delete character before the cursor
-- visual:bind({}, 'd', delete, nil, delete)
-- visual:bind({}, 'x', delete, nil, delete)

-- -- y - yank {{{2
-- visual:bind({}, 'y', function()
--     hs.eventtap.keyStroke({"cmd"}, "c")
--     hs.timer.doAfter(0.1, function()
--     visual:exit()
--     normal:enter()
--     hs.eventtap.keyStroke({}, "Right")
--     hs.alert.show('Normal mode')
-- end)
-- end)
-- -- }}}2

-- -- p - paste {{{2
-- visual:bind({}, 'p', function()
--     hs.eventtap.keyStroke({"cmd"}, "v")
--     visual:exit()
--     normal:enter()
--     hs.eventtap.keyStroke({}, "Right")
--     hs.alert.show('Normal mode')
-- end)
-- -- }}}2

-- -- }}}1

-- Don't activate in MacVim or iTerm or Terminal
hs.window.filter.new('MacVim')-- {{{1
    :subscribe(hs.window.filter.windowFocused,function()
        normal:exit()
        enterNormal:disable()
    end)
    :subscribe(hs.window.filter.windowUnfocused,function()
        enterNormal:enable()
    end)-- }}}1

hs.window.filter.new('iterm')
    :subscribe(hs.window.filter.windowFocused,function()
        normal:exit()
        enterNormal:disable()
    end)
    :subscribe(hs.window.filter.windowUnfocused,function()
        enterNormal:enable()
    end)

hs.window.filter.new('Terminal')
    :subscribe(hs.window.filter.windowFocused,function()
        normal:exit()
        enterNormal:disable()
    end)
    :subscribe(hs.window.filter.windowUnfocused,function()
        enterNormal:enable()
    end)


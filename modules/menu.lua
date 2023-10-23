local beautiful      = require("beautiful")
local hotkeys_popup  = require("awful.hotkeys_popup")
local awful          = require("awful")

-- {{{ Menu
-- Custom menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", Terminal .. "-e man awesome" },
   { "edit config", Editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
local menu_terminal = { "open terminal", Terminal }

if has_fdo then
    mymainmenu = freedesktop.menu.build({
        before = { menu_awesome },
        after =  { menu_terminal }
    })
else
    mymainmenu = awful.menu({
        items = {
         menu_awesome,
         menu_terminal,
         }
    })
end

local beautiful      = require("beautiful")
local awful          = require("awful")
local helpers        = require("helpers")
local gears          = require("gears")

client.connect_signal("manage", function (c)
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("button::pressd", function(c)
    c.shape = gears.shape.rectangle
end)


client.connect_signal("focus", function(c)
  c.border_color = beautiful.border_focus
end)

client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Rounded corners
local function enable_rounding()
   if beautiful.rounded and beautiful.rounded > 0 then
       client.connect_signal("manage", function (c)
           if not c.fullscreen and not c.maximized then
               c.shape = helpers.rrect(beautiful.rounded)
           end
       end)

       local function no_round_corners (c)
           if c.fullscreen then
               c.shape = nil
           elseif c.maximized then
               c.shape = helpers.prrect(beautiful.rounded, true, true, false, false)
           else
               c.shape = helpers.rrect(beautiful.rounded)
           end
       end

       client.connect_signal("property::fullscreen", no_round_corners)
       client.connect_signal("property::maximized", no_round_corners)

       beautiful.snap_shape = helpers.rrect(beautiful.rounded)
   else
       beautiful.snap_shape = gears.shape.rectangle
   end
end

enable_rounding()

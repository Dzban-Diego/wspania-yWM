local awful          = require("awful")
local gears          = require("gears")
local menubar        = require("menubar")
local wibox          = require("wibox")
local beautiful      = require("beautiful")

-- Ustawia terminal
menubar.utils.terminal = Terminal

-- zaokrąglenie narożników
local rounded = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 3)
end

local function pointerCursor ()
   local widget = mouse.current_wibox
   if widget then
      widget.cursor = "hand2"
   end
end

local function defaultCursor ()
   local widget = mouse.current_wibox
   if widget then
      widget.cursor = "left_ptr"
   end
end

-- Zachowanie myszki na liście Tagów
local taglist_buttons = gears.table.join(
   awful.button({}, 1, function(t) t:view_only() end),
   awful.button({Modkey}, 1, function(t)
      if client.focus then
         client.focus:move_to_tag(t)
      end
   end),
   awful.button({}, 3, awful.tag.viewtoggle),
   awful.button({Modkey}, 3, function(t)
      if client.focus then
         client.focus:toggle_tag(t)
      end
   end),
   awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
   awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
   awful.button({}, 1, function (c)
      if c == client.focus then
         c.minimized = true
      else
         c:emit_signal(
            "request::activate",
            "tasklist",
            {raise = true}
         )
      end
   end),
   awful.button({}, 3, function()
      awful.menu.client_list({ theme = { width = 200 } })
   end),
   awful.button({}, 4, function ()
      awful.client.focus.byidx(1)
   end),
   awful.button({}, 5, function ()
      awful.client.focus.byidx(-1)
   end)
)

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function ()
   awful.spawn('variety -n')
end)

-- For each screen
awful.screen.connect_for_each_screen(function(s)
   -- Wszystkie ekrany
   awful.tag({ " ", " ", " ", " ", " " }, s, awful.layout.layouts[1])

   -- dodanie układów do ekranu
   s.mylayoutbox = awful.widget.layoutbox(s)

   -- podpęcie myszki do układów
   s.mylayoutbox:buttons(gears.table.join(
      awful.button({}, 1, function () awful.layout.inc( 1) end),
      awful.button({}, 3, function () awful.layout.inc(-1) end),
      awful.button({}, 4, function () awful.layout.inc( 1) end),
      awful.button({}, 5, function () awful.layout.inc(-1) end)
   ))

   -- taglist
   local mytaglists = awful.widget.taglist{
      screen  = s,
      filter  = awful.widget.taglist.filter.all,
      style = {
         shape = rounded
      },
      widget_template = {
         {
            {
               {
                  {
                     id     = 'index_role',
                     widget = wibox.widget.textbox,
                  },
                  widget  = wibox.container.margin,
               },
               {
                  id     = 'text_role',
                  widget = wibox.widget.textbox,
               },
               layout = wibox.layout.fixed.horizontal,
            },
            left = 10,
            right = 5,
            top = 2,
            bottom = 2,
            widget = wibox.container.margin
         },
         id     = 'background_role',
         bg     = '#ff00ff',
         widget = wibox.container.background,
      },
      buttons = taglist_buttons,
   }

   s.mytaglist = wibox.widget{
      {
         {
            widget = mytaglists
         },
         bg = '#575757',
         shape = rounded,
         widget = wibox.container.background,
      },
      top = 2,
      bottom = 2,
      left = 2,
      right = 2,
      widget = wibox.container.margin
   }

   -- tasklist
   s.mytasklist = awful.widget.tasklist {
      screen  = s,
      filter  = awful.widget.tasklist.filter.currenttags,
      buttons = tasklist_buttons,
      style   = {
         shape = rounded
      },
      layout   = {
         spacing_widget = {
            {
               forced_width  = 1,
               forced_height = 1,
               thickness     = 1,
               color         = '#777777',
               widget        = wibox.widget.separator
            },
            valign = 'center',
            halign = 'center',
            widget = wibox.container.place,
        },
        spacing = 1,
        layout  = wibox.layout.fixed.horizontal
      },
      widget_template = {
         {
            {
               {
                  {
                     id     = "icon_role",
                     widget = wibox.widget.imagebox,
                  },
                  margins = 5,
                  widget  = wibox.container.margin,
               },
               {
                  id     = "text_role",
                  widget = wibox.widget.textbox,
               },
               layout = wibox.layout.fixed.horizontal,
            },
            left  = 5,
            right = 10,
            widget = wibox.container.margin
         },
         forced_width = 200,
         id     = "background_role",
         widget = wibox.container.background,
      },
   }

   -- widgets
   -- audio / spotify / cpu / logout / batter
   local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
   local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
   local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
   local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
   local logout_popup = require("awesome-wm-widgets.logout-popup-widget.logout-popup")
   local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")

   local mytextclock = wibox.widget.textclock('  %a %b %d, %H:%M')

   local cw = calendar_widget({
      theme = 'dark',
      placement = 'top_right',
      radius = 5,
      previous_month_button = 1,
      next_month_button = 3,

   })

   mytextclock:connect_signal("button::press",
      function(_, _, _, button)
         if button == 1 then cw.toggle() end
      end
   )

    -- systrey (domyślnie ukryte)
   local mysystrey = wibox.widget.systray()
   s.customSysTrey = wibox.widget {
      {
         {
            widget = mysystrey,
         },
         top = 5,
         bottom = 5,
         left = 8,
         right = 8,
         widget = wibox.container.margin,
      },
      bg = beautiful.bg_normal,
      shape = gears.shape.rounded_bar,
      widget = wibox.container.background
   }
   s.customSysTrey.visible = false

   -- Create the wibox
   s.mywibox = awful.wibar({ position = "top", screen = s})

   -- Add widgets to the wibox
   s.mywibox:setup {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
         layout = wibox.layout.fixed.horizontal,
         s.mylayoutbox,
         s.mytaglist,
         s.mypromptbox,
      },
      s.mytasklist, -- Middle widget
      { -- Right widgets
          {
            layout = wibox.layout.fixed.horizontal,
            cpu_widget({
               width = 40,
               step_width = 2,
               step_spacing = 0,
               color = '#ffffff',
            }),
            battery_widget(),
            volume_widget{
               widget_type = 'arc'
            },
            brightness_widget({
               program = 'xbacklight',
               step = 10,
            }),
            s.customSysTrey,
            mytextclock,
            logout_popup.widget{
               phrases = {'NARRA'}
            },
         },
         top = 2,
         bottom = 2,
         right = 2,
         widget = wibox.container.margin,
      },
   }
   s.mywibox:connect_signal("mouse::enter", pointerCursor)
   s.mywibox:connect_signal("mouse::enter", defaultCursor)
end)

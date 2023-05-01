pcall(require, "luarocks.loader")

-- Standard awesome library
local gears          = require("gears")
local awful          = require("awful")
local wibox          = require("wibox")
local beautiful      = require("beautiful")
local helpers        = require("helpers")
local naughty        = require("naughty")
local menubar        = require("menubar")
local hotkeys_popup  = require("awful.hotkeys_popup")
require("awful.autofocus")
require("awful.hotkeys_popup.keys")
require("collision")()
require("keys")

local capi = { screen = screen, mouse = mouse }

-- {{{ Error handling
if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
  title = "Oops, there were errors during startup!",
  text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}


local function pointer ()
    local widget = capi.mouse.current_wibox
    if widget then
        widget.cursor = "hand2"
    end
end

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(string.format("%s/.config/awesome/themes/theme.lua", os.getenv("HOME"), chosen_theme))

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.floating,
  awful.layout.suit.fair.horizontal,
}
-- }}}

-- Rounded corners
local function enable_rounding()
   if beautiful.rounded and beautiful.rounded > 0 then
       client.connect_signal("manage", function (c, startup)
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

-- {{{ Menu
-- Custom menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
local menu_terminal = { "open terminal", terminal }

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

mylauncher = awful.widget.launcher({
   image = beautiful.awesome_icon,
   menu = mymainmenu
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

local rounded = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 3)
end

-- {{{ Wibar
-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
   awful.button({ }, 1, function(t) t:view_only() end),
   awful.button({ modkey }, 1, function(t)
      if client.focus then
         client.focus:move_to_tag(t)
      end
   end),
   awful.button({ }, 3, awful.tag.viewtoggle),
   awful.button({ modkey }, 3, function(t)
      if client.focus then
         client.focus:toggle_tag(t)
      end
   end),
   awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
   awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
   awful.button({ }, 1, function (c)
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
   awful.button({ }, 3, function()
      awful.menu.client_list({ theme = { width = 2 } })
   end),
   awful.button({ }, 4, function ()
      awful.client.focus.byidx(1)
   end),
   awful.button({ }, 5, function ()
      awful.client.focus.byidx(-1)
   end)
)

-- Wallpaper
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
--screen.connect_signal("property::geometry", set_wallpaper)

-- For each screen
awful.screen.connect_for_each_screen(function(s)
   -- Wallpaper
   --set_wallpaper(s)

   -- Each screen has its own tag table.
   awful.tag({ " ", " ", "﬏ ", " ", " " }, s, awful.layout.layouts[1])
   -- awful.tag({ "1" }, s, awful.layout.layouts[0])

   -- Create a promptbox for each screen
   s.mypromptbox = awful.widget.prompt()

   -- layautbox
   s.mylayoutbox = awful.widget.layoutbox(s)

   s.mylayoutbox:buttons(gears.table.join(
      awful.button({ }, 1, function () awful.layout.inc( 1) end),
      awful.button({ }, 3, function () awful.layout.inc(-1) end),
      awful.button({ }, 4, function () awful.layout.inc( 1) end),
      awful.button({ }, 5, function () awful.layout.inc(-1) end)
   ))

   -- taglist
   mytaglists = awful.widget.taglist {
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
         bg = '#ff00ff',
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
            left  = 10,
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
   local spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify")
   local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
   local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
   local battery_widget = require("awesome-wm-widgets.battery-widget.battery")
   local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
   local logout_popup = require("awesome-wm-widgets.logout-popup-widget.logout-popup")
   local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")


    mytextclock = wibox.widget.textclock()
    -- default
    local cw = calendar_widget()
    -- or customized
    local cw = calendar_widget({
        theme = 'outrun',
        placement = 'top_right',
        radius = 8,
        -- with customized next/previous (see table above)
        previous_month_button = 1,
        next_month_button = 3,
    })

    mytextclock:connect_signal("button::press",
    function(_, _, _, button)
        if button == 1 then cw.toggle() end
    end)

    mytextclock:connect_signal("button::enter",
            function()
                pointer()
            end)

    -- systrey (hide)
   mysystrey = wibox.widget.systray()
   s.myOwnWidget = wibox.widget {
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
   s.myOwnWidget.visible = false

   -- clock
   mynewTextclock = wibox.widget {
      {
         {
            widget = wibox.widget.textclock(" %H:%M ") -- A/a Dzień B/b miesiac c wszystko d dzienWmsc F data G rok
         },
         shape = gears.shape.rounded_bar,
         widget = wibox.container.background,
      },
      bg = '#000000',
      shape = gears.shape.rounded_bar,
      widget = wibox.container.background
   }

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
            s.myOwnWidget,
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
end)
-- }}}

-- -- Set keys
root.keys(globalkeys)
-- -- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {

   -- Spotify
   { rule = {
      class = "Spotify"
   },properties = {
      screen = 1,
      tag = awful.screen.focused().tags[5]
   }},

   { rule = {
      class = "obs"
   },properties = {
      screen = 1,
      tag = awful.screen.focused().tags[8]
   }},

   { rule = {
    instance = "re.sonny.Tangram"
    },properties = {
        screen = 1,
        -- tag = awful.screen.focused().tags[2]
    }},

    { rule = {
    class = "code"
    },properties = {
        -- screen = 1,
        -- tag = awful.screen.focused().tags[2]
    }},

    { rule = {
      fullscreen = true
    },properties = {
       tag = awful.screen.focused().tags[1],
      shape = rectangle,

    }},

   -- All clients will match this rule.
   { rule = { },
   properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
   },
   },

   --Notatki
   { rule_any = {
      instance = {
         "notatki",
         "floating",
      },
   },properties = {
      floating = true,
      ontop = true,
      placement = awful.placement.centered,
      width = 500,
      height = 500,
      --tag = awful.screen.focused().tags[1]
   }},

   --Airplay
   { rule_any = {
      class = {
         "uxplay",
      },
   },properties = {
      floating = true,
      ontop = true,
      placement = awful.placement.centered,
      width = 500,
      height = 500,
      tag = awful.screen.focused().tags[1]
   }},


   -- Floating clients.
   { rule_any = {
      instance = {
         "DTA",  -- Firefox addon DownThemAll.
         "copyq",  -- Includes session name in class.
         "pinentry",
         "xzoom",
         "zoom",
         "emulator64-cras",
         "qemu-system-x86",
      },
      class = {
         "Arandr",
         "Blueman-manager",
         "Gpick",
         "Kruler",
         "MessageWin",  -- kalarm.
         "Sxiv",
         "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
         "Wpa_gui",
         "veromix",
         "emulator64-cras",
         "emulator",
         "qemu",
         "qemu-system-x86",
         "xtightvncviewer"},

      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
         "Event Tester",  -- xev.
         "splash",
         "qemu-system-x86",
         "Android Emulator - Pixel:5554",
         "emulator64-cras",
         "Welcome to PhpStorm",
      },
      role = {
         "AlarmWindow",  -- Thunderbird's calendar.
         "ConfigManager",  -- Thunderbird's about:config.
         "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
         "xzoom",

      }
   }, properties = { floating = true }},

   -- Add titlebars to normal clients and dialogs
   { rule_any = {type = { "normal", "dialog" }
   }, properties = { titlebars_enabled = false }
   },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
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
-- }}}


--autostart
-- awful.spawn.with_shell('uxplay')
-- awful.spawn.with_shell('sudo obs')
-- awful.spawn.with_shell('spotify')
awful.spawn.with_shell('picom -b')
awful.spawn.with_shell('variety -n')

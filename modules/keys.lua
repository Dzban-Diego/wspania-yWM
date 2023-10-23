local gears          = require("gears")
local awful          = require("awful")
local hotkeys_popup  = require("awful.hotkeys_popup")
local logout_popup   = require("awesome-wm-widgets.logout-popup-widget.logout-popup")
local volume_widget  = require('awesome-wm-widgets.volume-widget.volume')
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")

local connectAirPods = require('functions.connectAirPods')

local Apps = 'Aplikacje'
local Functions = 'Funkcje'
local Awesome = 'Wspaniałe'
local Client = 'Okno'
local Tags = 'Tagi'
local Layout = 'Układ'
local Audio = 'Audio'

local Shift = 'Shift'
local Control = 'Control'

local key = function (modifier, key, func, descripion, group, c)
  if modifier == nil then
    modifier = {Modkey}
  else
    if type(modifier) == 'string' then
      modifier = {Modkey, modifier}
    end
  end
  if group == nil then
    group = Apps
  end
  return awful.key(modifier, key,
    function ()
      if type(func) == "string" then
        awful.spawn(func)
      else
        func(c)
      end
    end, {description = descripion, group = group}
  )
end

awful.keyboard.append_global_keybindings({
  awful.key({Modkey}, "i", function ()
    print('kupa')
  end),
  -- Ustawienie tapety
  key(_, '.', 'variety -n', 'Następna tapeta', Functions),
  key(_, ',', 'variety -p', 'Poprzednia tapeta', Functions),
  key(_, 'F1', hotkeys_popup.show_help, 'Pomoc', Awesome),
  key(Control, 'r', awesome.restart, 'Odświerz awesome', Awesome),
  key(Control, 'q', awesome.quit, 'Wyłącz awesome', Awesome),
  key(Shift, 'q',
    function ()
      logout_popup.launch({
          phrases = { 'Do widzenia!' }
        })
    end, 'Wyloguj', Awesome),

  key(_, '=', function ()
      awful.screen.focused().customSysTrey.visible = not awful.screen.focused().customSysTrey.visible
  end, 'Pokaż systrey', Functions),
  key(_, '-', function ()
      awful.screen.focused().mywibox.visible = not awful.screen.focused().mywibox.visible
  end, 'Pokaż wibar', Functions),

  key(_, 'a', connectAirPods, 'Połącz Airpodsy', Functions),
  key(_, 'Print', 'flameshot gui', 'Zrób zrzut ekranu', Functions),

  -- Tags
  key(_, 'Left', awful.tag.viewprev, 'Poprzedni ekran', Tags),
  key(_, 'Right', awful.tag.viewnext, 'Następny ekran', Tags),
  key(_, 'Escape', awful.tag.history.restore, 'Wróć', Tags),

  --Okno
  key(_, 'Tab', function ()
      awful.client.focus.byidx(1)
  end, 'Następne okno', Client),
  key(Shift, 'Tab', function ()
      awful.client.focus.byidx(-1)
  end, 'Poprzednie okno', Client),
  key(Shift, 'Up', function ()
      awful.client.swap.byidx(-1)
  end, 'Zamień okna', Client),
  key(Shift, 'Up', function ()
    awful.client.swap.byidx(-1)
  end, 'Zamień okna odwrotnie', Client),

  key(Control, 'n', function ()
      local c = awful.client.restore()
      if c then
        c:emit_signal("request::activate", "key.unminimize", {raise = true})
      end
  end, 'Przywróć zminimalizowane okno', Client),


  -- Aplikacje
  key(_, 'Return', 'alacritty', 'Terminal', Apps),
  key(_, 'r', 'run.sh', 'Znajdź program', Apps),
  key('shift', 'r' , 'dmenu_run -l -i -p Program: -fn SF Pro', 'Znajdź więcej programów', Apps),
  key(_, 'b', 'thorium-browser', 'Przeglądarka', Apps),
  key(_, 'e', 'thunar', 'Pliki', Apps),
  key(_, 'z', 'zoom', 'Zoom', Apps),
  key(_, 's', 'spotify', 'Spotify', Apps),

  -- Układ
  key(Shift, 'Right', function ()
    awful.tag.incmwfact(0.05)
  end, 'Poszerz', Layout),
  key(Shift, 'Left', function ()
    awful.tag.incmwfact(-0.05)
  end, 'Zwęź', Layout),


  -- Funkcyjne
  key({}, 'XF86MonBrightnessUp', function ()
    brightness_widget:inc()
  end, 'Jasniej', Functions),
  key({}, 'XF86MonBrightnessDown', function ()
    brightness_widget:dec()
  end, 'Ciemniej', Functions),

  -- Audio
  key({}, "XF86AudioPrev",
    function()
      awful.spawn('playerctl previous')
    end, 'Poprzedni utwór', Audio
  ),
  key({}, 'XF86AudioNext',
    function ()
      awful.spawn('playerctl next')
    end, 'Następny utwór', Audio
  ),
  key({}, 'XF86AudioPlay',
    function()
      awful.spawn('playerctl play-pause')
    end, 'Zatrzymaj/Odtwórz', Audio
  ),
  key({}, 'XF86AudioMute', volume_widget.toggle, 'Wycisz', Audio),
  key({}, 'XF86AudioRaiseVolume',
    function ()
      volume_widget:inc(5)
    end, 'Podgłośnij', Audio
  ),
  key({}, 'XF86AudioLowerVolume',
    function ()
      volume_widget:dec(5)
    end, 'Przycisz', Audio
  ),
})

---@diagnostic disable-next-line: lowercase-global
clientkeys = gears.table.join(
  awful.key({Modkey}, "f",
    function (c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end, {description = "Pełny ekran", group = Client}
  ),
  awful.key({Modkey}, "q",
    function (c)
      c:kill()
    end, {description = "Zamknij", group = Client}
  ),
  awful.key({Modkey, Control }, "space",
    awful.client.floating.toggle,
    {description = "Zwolnij okno", group = Client}
  ),
  awful.key({Modkey, Control}, "Return",
    function (c)
      c:swap(awful.client.getmaster())
    end, {description = "Ustaw jako główne okno", group = Client}
  ),
  awful.key({Modkey}, "Page_Down",
    function (c)
      c:move_to_screen()
    end, {description = "Przesuń na drugi ekran", group = Client}
  ),
  awful.key({Modkey, Control}, "t",
    function (c)
      c.ontop = not c.ontop
    end, {description = "Zawsze u góry", group = Client}
  ),
  awful.key({Modkey}, "n",
    function (c)
      c.minimized = true
    end, {description = "Minimalizuj", group = Client}
  ),
  awful.key({Modkey}, "m",
    function (c)
      c.maximized = not c.maximized
      c:raise()
    end, {description = "Maksymalizuj", group = Client}
  )
)
-- Zachowanie myszki na pulpicie
root.buttons(gears.table.join(
  awful.button({}, 1, function () awful.spawn('variety -n') end),
  awful.button({}, 3, function () awful.spawn('variety -p') end),
  awful.button({}, 2, function () mymainmenu:toggle() end),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)
))

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
local globalkeys
for i = 1, 9 do
  globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key({ Modkey }, "#" .. i + 9,
      function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end
    ),

    -- Toggle tag display.
    awful.key({ Modkey, "Control" }, "#" .. i + 9,
      function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end
    ),
    -- Move client to tag.
    awful.key({ Modkey, "Shift" }, "#" .. i + 9,
      function ()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:move_to_tag(tag)
          end
        end
      end
    ),

    -- Toggle tag on focused client.
    awful.key({ Modkey, "Control", "Shift" }, "#" .. i + 9,
      function ()
        if client.focus then
          local tag = client.focus.screen.tags[i]
          if tag then
            client.focus:toggle_tag(tag)
          end
        end
      end
    )
  )
end
root.keys(globalkeys)

-- Kliknięcie myszy na oknie
---@diagnostic disable-next-line: lowercase-global
clientbuttons = gears.table.join(
  awful.button({ }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
  end),
  awful.button({ Modkey }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.move(c)
  end),
  awful.button({ Modkey }, 3, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.resize(c)
  end)
)

local gears          = require("gears")
local awful          = require("awful")
local hotkeys_popup  = require("awful.hotkeys_popup")
local naughty        = require("naughty")
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
local logout_popup = require("awesome-wm-widgets.logout-popup-widget.logout-popup")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")

modkey = "Mod4"

-- Awesome
awful.keyboard.append_global_keybindings({

  awful.key(                                                        { modkey, },            ".",
    function ()
      awful.spawn('variety -n')
    end,
    {description="Następna tapeta", group="Funkcyjne"}
  ),
  awful.key(                                                        { modkey, },            ",",
    function ()
      awful.spawn('variety -p')
    end,
    {description="Poprzednia tapeta", group="Funkcyjne"}
  ),
  awful.key(                                                        { modkey, },            "F1",
    hotkeys_popup.show_help,
    {description="Pomoc", group="Funkcyjne"}
  ),
  awful.key(                                                        { modkey, },            "XF86MonBrightnessDown",
    hotkeys_popup.show_help,
    {description="Pomoc", group="Funkcyjne"}
  ),
  awful.key(                                                        { modkey, "Control" },  "r",
    awesome.restart,
    {description = "Odświerz awesome", group = "Funkcyjne"}
  ),
  awful.key(                                                        { modkey, "Shift" },    "q",
    function ()
        logout_popup.launch({
          phrases = {'NARRA'}
        })
    end,
    {description = "Wyłącz", group = "Funkcyjne"}
  ),
  awful.key(                                                        { modkey },             "=", 
    function ()
      awful.screen.focused().myOwnWidget.visible = not awful.screen.focused().myOwnWidget.visible
    end, {description = "Pokaż systrey", group = "Funkcyjne"}
  ),
  awful.key(                                                          { modkey },             "-",
    function ()
      awful.screen.focused().mywibox.visible = not awful.screen.focused().mywibox.visible
    end, {description = "Pokaż wibar", group = "Funkcyjne"}
  ),

  -- Istotne
  awful.key(                                                        { modkey, },            "F12",
    function ()
      awful.spawn('bluetoothctl connect DC:2C:26:32:7F:01')
    end,
    {description="Podlacz klawke", group="Istotne"}
  ),
  awful.key(                                                        { modkey, },            "a",
    function ()
        awful.spawn('bluetoothctl connect 9C:FC:28:55:02:CD')
    end,
    {description = "Połącz Airpodsy", group = "Istotne"}
  ),
  awful.key(                                                        { modkey, },            "x",
    function ()
        awful.spawn("./.scripts/notatki.sh")
    end,
    {description = "Notatki", group = "Istotne"}
  ),
  awful.key(                                                        { modkey, },            "d",
    function ()
        awful.spawn("./.scripts/xrandr.sh")
    end,
    {description = "Monitory", group = "Istotne"}
  ),
  awful.key(                                                        { modkey, },            "c",
    function ()
        awful.spawn("./.scripts/bluetooth.sh")
    end,
    {description = "Bluetooth", group = "Istotne"}
  ),
  awful.key(                                                        {  },                   "Print",
    function ()
        awful.spawn("flameshot gui")
    end,
    {description = "SS", group = "Istotne"}
  ),
  awful.key(                                                        { modkey, },             ";",
    function ()
        awful.spawn("setxkbmap pl -variant colemak_dh_ansi");
    end,
    {description = "zmien układ klawiatury - colemak", group = "Istotne"}
  ),
  awful.key(                                                        { modkey, },             "o",
    function ()
        awful.spawn("setxkbmap pl")
    end,
    {description = "zmien układ klawiatury - qwerty", group = "Istotne"}
  ),

  -- Tags
  awful.key(                                                        { modkey, },            "Left",
    awful.tag.viewprev,
    {description = "Poprzedni ekran", group = "Tagi"}
  ),
  awful.key(                                                        { modkey, },            "Right",
    awful.tag.viewnext,
    {description = "Następny ekran", group = "Tagi"}
  ),
  awful.key(                                                        { modkey, },            "Escape",
    awful.tag.history.restore,
    {description = "Wróć", group = "Tagi"}
  ),

  --Okno
  awful.key(                                                        { modkey, },            "Down",
    function ()
      awful.client.focus.byidx( 1)
    end,
    {description = "Następne okno", group = "Okno"}
  ),
  awful.key(                                                        { modkey, },            "Up",
    function ()
      awful.client.focus.byidx(-1)
    end,
    {description = "Poprzednie okno", group = "Okno"}
  ),
  awful.key(                                                        { modkey, "Shift" },    "Down",
    function ()
      awful.client.swap.byidx(  1 )
    end,
    {description = "Zmień okna", group = "Okno"}
  ),
  awful.key(                                                        { modkey, "Shift" },    "Up",
    function ()
      awful.client.swap.byidx( -1 )
    end,
    {description = "Zmień okna odwrotnie", group = "Okno"}
  ),
  awful.key(                                                        { modkey, },            "Tab",
    function ()
      awful.client.focus.history.previous()
      if client.focus then
            client.focus:raise()
      end
    end,
    {description = "Poprzednie okno", group = "Okno"}
  ),
  awful.key(                                                        { modkey, "Control" },  "n",
    function ()
      local c = awful.client.restore()
      if c then
        c:emit_signal("request::activate", "key.unminimize", {raise = true})
      end
    end,
    {description = "Przywróć zminimalizowane okno", group = "Okno"}
  ),
  
  -- Odpal
  awful.key(                                                        { modkey, },            "Return",
    function ()
      awful.spawn(terminal)
    end,
    {description = "Terminal", group = "Odpal"}
  ),
  awful.key(                                                        { modkey, },            "m",
    function ()
      awful.spawn('minecraft-launcher')
    end,
    {description = "Kloce", group = "Odpal"}
  ),
  awful.key(                                                        { modkey, },            "c",
    function ()
      awful.spawn('rofi -show calc')
    end,
    {description = "Kalkulator", group = "Odpal"}
  ),
  awful.key(                                                        { modkey, "Shift" },    "Return",
    function ()
      awful.spawn('terminator --class floating')
    end,
    {description = " terminal", group = "Odpal"}
  ),
  awful.key(                                                        { modkey, },            "r",
    function ()
      awful.spawn('dmenu_run -l -i -p Program: -fn Hack')
    end,
    {description = "Znajdź program", group = "Odpal"}
  ),
  awful.key(                                                        { modkey, },            "b",
    function ()
      awful.spawn('google-chrome-stable')
    end,
    {description = "Przeglądarka", group = "Odpal"}
  ),
  awful.key(                                                        { modkey, },            "v",
    function ()
      awful.spawn('code_dmenu')
    end,
    {description = "VSC", group = "Odpal"}
  ),
  awful.key(                                                        { modkey, },            "e",
    function ()
      awful.spawn('thunar .')
    end,
    {description = "Pliki", group = "Odpal"}
  ),
  awful.key(                                                        { modkey, },            "h",
    function ()
      awful.spawn('heroic')
    end,
    {description = "Heroic", group = "Odpal"}
  ),
  awful.key(                                                        { modkey, },            "t",
    function ()
      awful.spawn('tablica')
    end,
    {description = "Tablica", group = "Odpal"}
  ),
  awful.key(                                                        { modkey, },            "z",
    function ()
      awful.spawn('zoom')
    end,
    {description = "Zoom", group = "Odpal"}
  ),
  awful.key(                                                        { modkey, },            "s",
    function ()
      awful.spawn('spotify', {floating = true})
    end,
    {description = "Spotify", group = "Odpal"}
  ),
  awful.key(                                                        { modkey, },            "k",
    function ()
      awful.spawn('sudo obs --startvirtualcam')
    end,
    {description = "OBS", group = "Odpal"}
  ),
  awful.key(                                                        { modkey, },            "y",
    function ()
      awful.spawn("google-chrome-stable --new-window youtube.com")
    end,
    {description = "youtube", group = "Odpal"}
  ),
  
  -- Układ
  awful.key(                                                        { modkey, "Shift"},     "Right",
    function ()
        awful.tag.incmwfact( 0.05)
    end,
    {description = "Poszerz", group = "Układ"}
  ),
  awful.key(                                                        { modkey, "Shift"},     "Left",
    function ()
        awful.tag.incmwfact(-0.05)
    end,
    {description = "Zwęź", group = "Układ"}
  ),
  awful.key(                                                        { modkey, },            "`",
    function ()
      awful.layout.inc( 1)
    end,
    {description = "Następny układ", group = "Układ"}
  ),
  awful.key(                                                        { modkey, "Shift" },    "`", 
    function ()
      awful.layout.inc(-1)
    end,
    {description = "Poprzedni układ", group = "Układ"}
  ),

  awful.key(                                                        { modkey, },           "Page_Up",
    function ()
      awful.screen.focus_relative( 1 )
    end,
  {description = "Zmień ekran", group = "Układ"}
  ),

  -- Funkcyjne  
  awful.key(                                                        { modkey },             "Control_R",
    function()
      awful.spawn('./.scripts/chfunc.sh')
      naughty.notify({title = ' Zmień funkcje', text = "Dawaj palucha by zmienić funkcyjne klawisze.", timeout = 10 })
    end, {description = "Zmień kunkcje", group = "Funkcyjne"}
  ),
  awful.key(                                                        {  },                   "XF86MonBrightnessUp",
    function()
      brightness_widget:inc()
    end, {description = "Jasniej", group = "Funkcyjne"}
  ),
  awful.key(                                                        {  },                   "XF86MonBrightnessDown",
    function()
      brightness_widget:dec()
    end, {description = "Ciemniej", group = "Funkcyjne"}
  ),

  -- Audio
  awful.key(                                                        {  },                   "XF86AudioPrev",
    function()
      awful.spawn('playerctl previous')
    end,
    {description = "玲", group = "Audio"}
  ),
  awful.key(                                                        {  },                   "XF86AudioPlay",
    function()
      awful.spawn('playerctl play-pause')
    end,
    {description = "懶", group = "Audio"}
  ),
  awful.key(                                                        {  },                   "XF86AudioNext",
    function ()
      awful.spawn('playerctl next')
    end,
    {description = "怜", group = "Audio"}
  ),
  awful.key(                                                        {  },                   "XF86AudioMute",
    function()
      volume_widget:toggle()
    end, {description = "婢", group = "Audio"}
  ),
  awful.key(                                                        {  },                   "XF86AudioLowerVolume",
    function ()
      volume_widget:dec(5)
    end,
    {description = "", group = "Audio"}
  ),
  awful.key(                                                        {  },                   "XF86AudioRaiseVolume",
    function ()
      volume_widget:inc(5)
    end,
    {description = "", group = "Audio"}
  )
})

clientkeys = gears.table.join(
  -- Okno
  awful.key(                                                        { modkey, },            "f",
    function (c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end,
    {description = "Pełny ekran", group = "Okno"}
  ),
  awful.key(                                                        { modkey, },            "q",
    function (c)
      c:kill()
    end,
    {description = "Zamknij", group = "Okno"}
  ),
  awful.key(                                                        { modkey, "Control" },  "space",
    awful.client.floating.toggle,
    {description = "Zwolnij okno", group = "Okno"}
  ),
  awful.key(                                                        { modkey, "Control" },  "Return",
    function (c)
      c:swap(awful.client.getmaster())
    end,
    {description = "Ustaw jako główne okno", group = "Okno"}
  ),
  awful.key(                                                        { modkey },     "Page_Down",
    function (c)
      c:move_to_screen()
    end,
    {description = "Przesuń na drugi ekran", group = "Okno"}
  ),
  awful.key(                                                        { modkey, "Control"},   "t",
    function (c)
      c.ontop = not c.ontop
    end,
    {description = "Zawsze u góry", group = "Okno"}
  ),
  awful.key(                                                        { modkey, },            "n",
    function (c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end,
    {description = "Minimalizuj", group = "Okno"}
  ),
  awful.key(                                                        { modkey, },            "m",
    function (c)
      c.maximized = not c.maximized
      c:raise()
    end,
    {description = "Maksymalizuj", group = "Okno"}
  )
)


-- Lepiej tego nie tykać
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
   globalkeys = gears.table.join(globalkeys,
      -- View tag only.
      awful.key({ modkey }, "#" .. i + 9,
               function ()
                     local screen = awful.screen.focused()
                     local tag = screen.tags[i]
                     if tag then
                        tag:view_only()
                     end
               end
               --{description = ""}
            ),
      -- Toggle tag display.
      awful.key({ modkey, "Control" }, "#" .. i + 9,
               function ()
                     local screen = awful.screen.focused()
                     local tag = screen.tags[i]
                     if tag then
                        awful.tag.viewtoggle(tag)
                     end
               end
               --{description = ""}
            ),
      -- Move client to tag.
      awful.key({ modkey, "Shift" }, "#" .. i + 9,
               function ()
                     if client.focus then
                        local tag = client.focus.screen.tags[i]
                        if tag then
                           client.focus:move_to_tag(tag)
                        end
                  end
               end
            --   {description = "move focused client to tag #"..i, group = "tag"}
            ),
      -- Toggle tag on focused client.
      awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
         function ()
               if client.focus then
                  local tag = client.focus.screen.tags[i]
                  if tag then
                     client.focus:toggle_tag(tag)
                  end
               end
         end
         --{description = "toggle focused client on tag #" .. i, group = "tag"}
      )
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)


pcall(require, "luarocks.loader")

-- Standard awesome library
local awful          = require("awful")
local beautiful      = require("beautiful")
require("awful.autofocus")
require("awful.hotkeys_popup.keys")
require("collision")()

-- Theme
beautiful.init(string.format("%s/.config/awesome/themes/theme.lua", os.getenv("HOME"), chosen_theme))

-- Tablica z układami
awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.floating,
  awful.layout.suit.fair.horizontal,
}
-- }}}
Terminal = "alacritty"
Editor = os.getenv("EDITOR") or "editor"
Editor_cmd = Terminal .. " -e " .. Editor
Modkey = "Mod4"

require("modules.errors")
require("modules.keys")
require("modules.rules")
require("modules.autostart")
require("modules.signals")
require("modules.bar")
require("modules.menu")

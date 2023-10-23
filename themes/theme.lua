-------------------------------
--  "Zenburn" awesome theme  --
--    By Adrian C. (anrxc)   --
-------------------------------

local themes_path = require("gears.filesystem").get_configuration_dir()
local dpi = require("beautiful.xresources").apply_dpi
local gears          = require("gears")

-- {{{ Main
local theme = {}
-- }}}

local colors = {
    pinki_fg_normal     = "#ff87d7",
    pinki_fg_focus      = "#ff5fd7",
    white_fg_normal     = "#ffffff",
    white_fg_focus      = "lightgrey",
    background          = "#000000",
}

-- {{{ Styles
theme.font       = "SF Pro Medium 11"
theme.wibar_height = 30
theme.wibar_border_width = 0
theme.wibar_opacity = 0.9
theme.wibar_bg = colors.background

theme.rounded = 5

theme.fg_normal  = colors.white_fg_normal  --czcionka
theme.fg_focus   = colors.white_fg_focus  --zaznaczona czcionka
theme.fg_urgent  = "#000000"  --holera wie
theme.bg_normal  = theme.wibar_bg  --tło
theme.bg_focus   = "#333333"-- theme.wibar_bg  --zaznaczone tło
theme.bg_systray = colors.white_bg_normal

theme.taglist_fg_occupied = '#000000'

theme.hotkeys_border_color = '#ff00ff'

local roundedShape = function(cr, width, height)
   gears.shape.rounded_rect(cr, width, height, theme.rounded)
end

theme.notification_max_width = 500
theme.notification_bg = theme.wibar_bg
theme.notification_fg = colors.fg_normal
theme.notification_shape = roundedShape
theme.notification_font = 'SF Pro Medium 11'
theme.notification_width = 300
theme.notification_icon_size = 70

-- {{{ Borders
theme.useless_gap   = 4
theme.border_width  = 2
theme.border_normal = "#3F3F3F"
theme.border_focus  = '#707070'
theme.border_marked = "#CC9393"
-- }}}

theme.systray_icon_spacing = 5

-- Calender
theme.textbox_font = 'Hack 5'

theme.tasklist_font = "SF Pro SemiBold 11"
theme.tasklist_shape_border_width = 2
theme.tasklist_shape_border_color = theme.wibar_bg
theme.tasklist_shape_border_bottom_width_focus = 5

theme.taglist_spacing = 3
theme.taglist_shape_border_width_focus = 2
theme.taglist_shape_border_color_focus = theme.wibar_bg
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- }}}

-- {{{ Menu
theme.menu_height = dpi(20)
theme.menu_width  = dpi(100)
-- }}}

-- {{{ Layout
theme.layout_tile       = themes_path .. "themes/layouts/tile.png"
theme.layout_tileleft   = themes_path .. "themes/layouts/tileleft.png"
theme.layout_tilebottom = themes_path .. "themes/layouts/tilebottom.png"
theme.layout_tiletop    = themes_path .. "themes/layouts/tiletop.png"
theme.layout_fairv      = themes_path .. "themes/layouts/fairv.png"
theme.layout_fairh      = themes_path .. "themes/layouts/fairh.png"
theme.layout_spiral     = themes_path .. "themes/layouts/spiral.png"
theme.layout_dwindle    = themes_path .. "themes/layouts/dwindle.png"
theme.layout_max        = themes_path .. "themes/layouts/max.png"
theme.layout_fullscreen = themes_path .. "themes/layouts/fullscreen.png"
theme.layout_magnifier  = themes_path .. "themes/layouts/magnifier.png"
theme.layout_floating   = themes_path .. "themes/layouts/floating.png"
theme.layout_cornernw   = themes_path .. "themes/layouts/cornernw.png"
theme.layout_cornerne   = themes_path .. "themes/layouts/cornerne.png"
theme.layout_cornersw   = themes_path .. "themes/layouts/cornersw.png"
theme.layout_cornerse   = themes_path .. "themes/layouts/cornerse.png"
-- }}}

return theme


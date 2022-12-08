-------------------------------
--  "Zenburn" awesome theme  --
--    By Adrian C. (anrxc)   --
-------------------------------

local themes_path = require("gears.filesystem").get_configuration_dir()
local dpi = require("beautiful.xresources").apply_dpi
local gears          = require("gears")

-- {{{ Main
local theme = {}
--theme.wallpaper = themes_path .. "custom/starship_BLACK1.svg"
-- }}}

-- {{{ Styles
theme.font       = "Hack Nerd Font 15"
theme.wibar_height = 30
theme.wibar_border_width = 0
theme.wibar_opacity = 0.9
theme.wibar_bg = '#000000'

theme.rounded = 3

local colors = {}
colors.pinki_fg_normal = "#ff87d7"
colors.pinki_fg_focus = "#ff5fd7"
colors.white_fg_normal = "#ffffff"
colors.white_fg_focus = "lightgrey"

-- {{{ Colors
theme.fg_normal  = colors.white_fg_normal  --czcionka
theme.fg_focus   = colors.white_fg_focus  --zaznaczona czcionka
theme.fg_urgent  = "#000000"  --holera wie
theme.bg_normal  = theme.wibar_bg  --tło
theme.bg_focus   = "#333333"-- theme.wibar_bg  --zaznaczone tło
theme.bg_urgent  = "#ff00ff"  --tez holera wie
theme.bg_systray = colors.white_bg_normal

theme.taglist_fg_occupied = '#000000'

theme.hotkeys_border_color = '#ff00ff'

local testss = function(cr, width, height)
   gears.shape.rounded_rect(cr, width, height, 10)
end

--theme.hotkey_shape = testss

theme.notification_max_width = 500
theme.notification_bg = theme.wibar_bg
theme.notification_fg = '#ffffff'
theme.notification_shape = testss
theme.notification_opacity = 5
theme.notification_font = 'SF Pro 10'
theme.notification_width = 300
-- theme.notification_height = 70
theme.notification_icon_size = 70

-- }}}

-- {{{ Borders
theme.useless_gap   = 4
theme.border_width  = 2
theme.border_normal = "#3F3F3F"
theme.border_focus  = '#707070'
theme.border_marked = "#CC9393"
-- }}}

--Sys trey
theme.systray_icon_spacing = 5

-- Calender
theme.textbox_font = 'Hack 5'

-- {{{ Titlebars
theme.titlebar_fg_normal  = "#ff00ff"
theme.titlebar_bg_normal = "#ff00f0"
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
theme.tasklist_font = "SF Pro 12"
theme.tasklist_shape_border_width = 2
theme.tasklist_shape_border_color = theme.wibar_bg
theme.tasklist_shape_border_bottom_width_focus = 5

--theme.taglist_spacing = 10
theme.taglist_bg = '#ff00ff'
theme.taglist_shape_border_width_focus = 2
theme.taglist_shape_border_color_focus = theme.wibar_bg
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(20)
theme.menu_width  = dpi(100)
-- }}}

-- {{{ Icons

-- {{{ Misc
theme.awesome_icon           = themes_path .. "zenburn/awesome-icon.png"
theme.menu_submenu_icon      = themes_path .. "default/submenu.png"
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

-- {{{ Titlebar
theme.titlebar_close_button_focus  = themes_path .. "zenburn/titlebar/close_focus.png"
theme.titlebar_close_button_normal = themes_path .. "zenburn/titlebar/close_normal.png"

theme.titlebar_minimize_button_normal = themes_path .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_focus_active  = themes_path .. "zenburn/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = themes_path .. "zenburn/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path .. "zenburn/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = themes_path .. "zenburn/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = themes_path .. "zenburn/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = themes_path .. "zenburn/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path .. "zenburn/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = themes_path .. "zenburn/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = themes_path .. "zenburn/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = themes_path .. "zenburn/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = themes_path .. "zenburn/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = themes_path .. "zenburn/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = themes_path .. "zenburn/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = themes_path .. "zenburn/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path .. "zenburn/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = themes_path .. "zenburn/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80

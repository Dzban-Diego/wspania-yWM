local awful = require("awful")

awful.spawn.with_shell('picom -b')
awful.spawn.with_shell('variety -n')
awful.spawn.with_shell("setxkbmap pl")

-- Start Houdini licence server
awful.spawn.with_shell('sudo /etc/init.d/sesinetd start')


local wibox = require("wibox")
local beautiful = require("beautiful")
local lain = require("lain")
local markup = lain.util.markup

local hdd_icons = wibox.widget{
    image = "/home/maren/.config/awesome/icons/bar/harddisk-icon.png",
    widget = wibox.widget.imagebox
}

local fs = lain.widget.fs({
    notification_preset = { fg = beautiful.fg_normal, bg = beautiful.bg_normal, font = beautiful.wibar },
    settings = function()
        local fsp = string.format(" %3.2f %s ", fs_now["/"].free, fs_now["/"].units)
        widget:set_markup(markup.font(beautiful.wibar, markup.fg.color(beautiful.fg_normal, fsp)))
    end
})
local fs_widget =  wibox.container.background(wibox.container.margin(wibox.widget { hdd_icons, fs.widget, layout = wibox.layout.align.horizontal }, 0, 0), beautiful.bg_widget4)


return fs_widget

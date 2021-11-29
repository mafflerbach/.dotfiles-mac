
local wibox = require("wibox")
local lain = require("lain")
local markup = lain.util.markup
local beautiful = require("beautiful")


local mem_icon = wibox.widget{
    image = "/home/maren/.config/awesome/icons/bar/memory-icon.png",
    widget = wibox.widget.imagebox
}
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(beautiful.wibar, markup.fg.color(beautiful.fg_normal, " " .. mem_now.used .. "/" .. mem_now.perc .. "%")))
    end
})

return wibox.container.background(wibox.container.margin(wibox.widget { mem_icon, mem.widget, layout = wibox.layout.align.horizontal }, 0, 0), beautiful.bg_widget2)

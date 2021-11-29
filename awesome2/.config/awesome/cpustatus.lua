local wibox = require("wibox")
local lain = require("lain")
local markup = lain.util.markup
local beautiful = require("beautiful")

local cpu_icon = wibox.widget{
    image = "/home/maren/.config/awesome/icons/bar/cpu-64-bit-icon.png",
    widget = wibox.widget.imagebox
}
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(beautiful.wibar, markup.fg.color(beautiful.fg_normal, " " .. cpu_now.usage .. "% ")))
    end
})
local cpu_widget =  wibox.container.background(wibox.container.margin(wibox.widget { cpu_icon, cpu.widget, layout = wibox.layout.align.horizontal }, 0, 0), beautiful.bg_widget3)


return cpu_widget

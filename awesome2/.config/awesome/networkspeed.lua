local beautiful = require("beautiful")
local lain = require("lain")
local markup = lain.util.markup
local wibox = require("wibox")

local mynetup = lain.widget.net {
    settings = function()
        widget:set_markup(markup.font(beautiful.wibar, markup.fg.color(beautiful.fg_normal, net_now.sent .. " /"  .. net_now.received)))
    end
}

local net_widget =  wibox.container.background(wibox.container.margin(wibox.widget { mynetup.widget, layout = wibox.layout.align.horizontal }, 0, 0), beautiful.bg_widget6)
return net_widget

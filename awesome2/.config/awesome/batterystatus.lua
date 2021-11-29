local lain = require("lain")
local wibox = require("wibox")
local beautiful = require("beautiful")
local markup = lain.util.markup

local mybat = lain.widget.net {
    settings = function()
        widget:set_markup(markup.font(beautiful.wibar, markup.fg.color(beautiful.fg_normal, bat_now.perc )))
    end
}

local bat_widget =  wibox.container.background(wibox.container.margin(wibox.widget { mybat.widget, layout = wibox.layout.align.horizontal }, 0, 0), beautiful.bg_widget5)

return bat_widget

local lain = require("lain")
local wibox = require("wibox")

local markup = lain.util.markup

local ttheme = {
font  = "NerdFont 10",
pink           = "#B85C8A"
}


local mem_icon = wibox.widget.imagebox("/home/maren/.config/awesome/icons/widgets/mem.png")

local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(ttheme.font, markup.fg.color("#32322f", " " .. mem_now.used .. "MB [" .. mem_now.perc .. "%]")))
    end
})
 mem_widget =  wibox.container.background(wibox.container.margin(wibox.widget { mem_icon, mem.widget, layout = wibox.layout.align.horizontal }, 0, 0), ttheme.pink)

 return mem_widget

local awful = require("awful")

local tagssettings = {}

function tagssettings.setup_tags(s)


    awful.tag.add("", {
        icon = "/home/maren/.config/awesome/icons/bar/circle-outline-1-icon.png",
        screen = s,
        layout             = awful.layout.suit.tile,
    selected           = true
    })
    awful.tag.add("", {
        icon = "/home/maren/.config/awesome/icons/bar/circle-outline-2-icon.png",
        screen = s,
        layout             = awful.layout.suit.tile,
    })
    awful.tag.add("", {
        icon = "/home/maren/.config/awesome/icons/bar/circle-outline-3-icon.png",
        screen = s,
        layout             = awful.layout.suit.tile,
    })
    awful.tag.add("", {
        icon = "/home/maren/.config/awesome/icons/bar/circle-outline-4-icon.png",
        screen = s,
        layout             = awful.layout.suit.tile,
    })
    awful.tag.add("", {
        icon = "/home/maren/.config/awesome/icons/bar/circle-outline-5-icon.png",
        screen = s,
        layout             = awful.layout.suit.tile,
    })
    awful.tag.add("", {
        icon = "/home/maren/.config/awesome/icons/bar/circle-outline-6-icon.png",
        screen = s,
        layout             = awful.layout.suit.tile,
    })
    awful.tag.add("", {
        icon = "/home/maren/.config/awesome/icons/bar/circle-outline-7-icon.png",
        screen = s,
        layout             = awful.layout.suit.tile,
    })
    awful.tag.add("", {
        icon = "/home/maren/.config/awesome/icons/bar/circle-outline-8-icon.png",
        screen = s,
        layout             = awful.layout.suit.tile,
    })

    awful.tag.add("", {
        icon = "/home/maren/.config/awesome/icons/bar/circle-outline-9-icon.png",
        screen = s,
        layout             = awful.layout.suit.tile,
    })
end


return tagssettings

local wibox = require("wibox")
local lain = require("lain")
local beautiful = require("beautiful")

local testwifistatus = wibox.widget{}
local wifi_icon = wibox.widget.imagebox()
local eth_icon = wibox.widget.imagebox()

local mynetup3 = lain.widget.net {
    notify = "off",
    wifi_state = "on",
    eth_state = "on",
    settings = function()
        local eth0 = net_now.devices.enp0s13f0u1u4
        if eth0 then
            if eth0.ethernet then
                eth_icon:set_image( "/home/maren/.config/awesome/icons/bar/ethernet-icon.png")
            else
                eth_icon:set_image( "/home/maren/.config/awesome/icons/bar/ethernet-cable-off-icon.png")
            end
        end

        local wlan0 = net_now.devices.wlp0s20f3
        if wlan0 then
            if wlan0.wifi then
                local signal = wlan0.signal
                if signal < -83 then
                    wifi_icon:set_image( "/home/maren/.config/awesome/icons/bar/wifi-strength-1-icon.png")
                elseif signal < -70 then
                    wifi_icon:set_image( "/home/maren/.config/awesome/icons/bar/wifi-strength-2-icon.png")
                elseif signal < -53 then
                    wifi_icon:set_image( "/home/maren/.config/awesome/icons/bar/wifi-strength-3-icon.png")
                elseif signal >= -53 then
                    wifi_icon:set_image( "/home/maren/.config/awesome/icons/bar/wifi-strength-4-icon.png")
                end
            else
                wifi_icon:set_image( "/home/maren/.config/awesome/icons/bar/wifi-strength-alert-outline-icon.png")
            end
        end

        testwifistatus = wibox.widget {
            {
                wifi_icon,
                eth_icon,
                layout = wibox.layout.fixed.horizontal
            },
            bg = beautiful.bg_widget6,
            widget = wibox.container.background
        }

    end

}

return testwifistatus

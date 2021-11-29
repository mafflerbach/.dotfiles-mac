local lain = require("lain")
  
local beautiful = require("beautiful")
local wibox = require("wibox")
local bat_icon2 = wibox.widget.imagebox()
local battery_status = wibox.widget {
}

local bat = lain.widget.bat({
    settings = function()


        if bat_now.perc <= 10   then
            bat_icon2:set_image( "/home/maren/.config/awesome/icons/bar/battery-10-icon.png")
        end
        if bat_now.perc >= 10 and  bat_now.perc <= 20  then
            bat_icon2:set_image( "/home/maren/.config/awesome/icons/bar/battery-10-icon.png")
        end
        if bat_now.perc >= 20 and  bat_now.perc <= 30  then
            bat_icon2:set_image( "/home/maren/.config/awesome/icons/bar/battery-20-icon.png")

        end
        if bat_now.perc >= 30 and  bat_now.perc <= 40  then
            bat_icon2:set_image( "/home/maren/.config/awesome/icons/bar/battery-30-icon.png")

        end
        if bat_now.perc >= 40 and  bat_now.perc <= 50  then
            bat_icon2:set_image( "/home/maren/.config/awesome/icons/bar/battery-40-icon.png")

        end
        if bat_now.perc >= 50 and  bat_now.perc <= 60  then
            bat_icon2:set_image( "/home/maren/.config/awesome/icons/bar/battery-50-icon.png")

        end
        if bat_now.perc >= 60 and  bat_now.perc <= 70  then
            bat_icon2:set_image( "/home/maren/.config/awesome/icons/bar/battery-60-icon.png")

        end
        if bat_now.perc >= 70 and  bat_now.perc <= 80  then
            bat_icon2:set_image( "/home/maren/.config/awesome/icons/bar/battery-70-icon.png")

        end
        if bat_now.perc >= 80 and  bat_now.perc <= 90  then
            bat_icon2:set_image( "/home/maren/.config/awesome/icons/bar/battery-80-icon.png")

        end
        if bat_now.perc >= 90 and  bat_now.perc <= 95  then
            bat_icon2:set_image( "/home/maren/.config/awesome/icons/bar/battery-90-icon.png")
        end
        if bat_now.perc >= 95 and  bat_now.perc <= 100  then
            bat_icon2:set_image( "/home/maren/.config/awesome/icons/bar/battery-icon.png")
        end


        if bat_now.status == "Charging" then
            if bat_now.perc >= 10 and  bat_now.perc <= 20  then
                bat_icon2:set_image( "/home/maren/.config/awesome/icons/bar/battery-charging-icon.png")
            end
            if bat_now.perc >= 20 and  bat_now.perc <= 30  then
                bat_icon2:set_image( "/home/maren/.config/awesome/icons/bar/battery-charging-icon.png")
            end
            if bat_now.perc >= 30 and  bat_now.perc <= 40  then
                bat_icon2:set_image( "/home/maren/.config/awesome/icons/bar/battery-charging-icon.png")
            end
            if bat_now.perc >= 40 and  bat_now.perc <= 50  then
                bat_icon2:set_image( "/home/maren/.config/awesome/icons/bar/battery-charging-icon.png")
            end
            if bat_now.perc >= 50 and  bat_now.perc <= 60  then
                bat_icon2:set_image( "/home/maren/.config/awesome/icons/bar/battery-charging-icon.png")
            end
            if bat_now.perc >= 60 and  bat_now.perc <= 70  then
                bat_icon2:set_image( "/home/maren/.config/awesome/icons/bar/battery-charging-icon.png")
            end
            if bat_now.perc >= 70 and  bat_now.perc <= 80  then
                bat_icon2:set_image( "/home/maren/.config/awesome/icons/bar/battery-charging-icon.png")
            end
            if bat_now.perc >= 80 and  bat_now.perc <= 90  then
                bat_icon2:set_image( "/home/maren/.config/awesome/icons/bar/battery-charging-icon.png")
            end
            if bat_now.perc >= 90 and  bat_now.perc <= 100  then
                bat_icon2:set_image( "/home/maren/.config/awesome/icons/bar/battery-charging-icon.png")
            end
        end

        battery_status = wibox.widget {
            {
                bat_icon2,
                layout = wibox.layout.fixed.horizontal
            },
            bg = beautiful.bg_widget5,
            widget = wibox.container.background
        }
    end
})


return battery_status

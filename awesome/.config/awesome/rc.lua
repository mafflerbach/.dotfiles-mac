
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local lain = require("lain")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local charitable = require("charitable")

require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
--beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init("/home/maren/.config/awesome/theme.lua")


-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
--     awful.layout.suit.corner.ne,
 --    awful.layout.suit.corner.sw,
  --   awful.layout.suit.corner.se,
--    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.tile,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.fair,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.magnifier
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.top,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.floating
    --awful.layout.suit.spiral,
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget

local markup = lain.util.markup

local clock_icon = wibox.widget{
    image = "/home/maren/.config/awesome/icons/bar/calendar-month-icon.png",
    widget = wibox.widget.imagebox
}
local clock = awful.widget.textclock(" %a %d %b  %H:%M ")
local clock_widget = wibox.container.background (
    wibox.container.margin(
        wibox.widget {
        clock_icon,
        clock,
        layout = wibox.layout.align.horizontal
    }, 0, 1), beautiful.bg_widget1
)

local calendar = lain.widget.calendar({
    cal = "cal --color=always",
    attach_to = { clock_widget },
    notification_preset = {
        font = beautiful.wibar,
        fg   = beautiful.fg_normal,
        bg   = beautiful.bg_normal
    }
})

-- FS
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


-- CPU
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

-- BAT 


local bat_icon = wibox.widget{
    markup = '',
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

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

local mybat = lain.widget.net {
    settings = function()
        widget:set_markup(markup.font(beautiful.wibar, markup.fg.color(beautiful.fg_normal, bat_now.perc )))
    end
}
 bat_widget =  wibox.container.background(wibox.container.margin(wibox.widget { mybat.widget, layout = wibox.layout.align.horizontal }, 0, 0), beautiful.bg_widget5)

-- MEM 
local mem_icon = wibox.widget{
    image = "/home/maren/.config/awesome/icons/bar/memory-icon.png",
    widget = wibox.widget.imagebox
}
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(beautiful.wibar, markup.fg.color(beautiful.fg_normal, " " .. mem_now.used .. "/" .. mem_now.perc .. "%")))
    end
})
 mem_widget =  wibox.container.background(wibox.container.margin(wibox.widget { mem_icon, mem.widget, layout = wibox.layout.align.horizontal }, 0, 0), beautiful.bg_widget2)

 -- NETWORK
local mynetup = lain.widget.net {
    settings = function()
        widget:set_markup(markup.font(beautiful.wibar, markup.fg.color(beautiful.fg_normal, net_now.sent .. " /"  .. net_now.received)))
    end
}
 net_widget =  wibox.container.background(wibox.container.margin(wibox.widget { mynetup.widget, layout = wibox.layout.align.horizontal }, 0, 0), beautiful.bg_widget6)

local wifi_icon = wibox.widget.imagebox()
local eth_icon = wibox.widget.imagebox()

local testwifistatus = wibox.widget{}

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



 spacer_widget =  wibox.container.background(wibox.container.margin(wibox.widget { wibox.widget.textbox(markup.font(beautiful.wibar, markup.fg.color(beautiful.fg_normal, "  " ))), layout = wibox.layout.align.horizontal }, 0, 0), beautiful.bg_widget6)


-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)
local tags = charitable.create_tags(

   { "","","","", "", "", "", "", "" },
   {
      awful.layout.layouts[1],
      awful.layout.layouts[1],
      awful.layout.layouts[1],
      awful.layout.layouts[1],
      awful.layout.layouts[1],
      awful.layout.layouts[1],
      awful.layout.layouts[1],
      awful.layout.layouts[1],
      awful.layout.layouts[1],
   },
   {
        "/home/maren/.config/awesome/icons/bar/console-icon.png",
        "/home/maren/.config/awesome/icons/bar/application-icon.png",
        "/home/maren/.config/awesome/icons/bar/message-reply-text-icon.png",
        "/home/maren/.config/awesome/icons/bar/email-open-icon.png",
        "/home/maren/.config/awesome/icons/bar/circle-outline-5-icon.png",
        "/home/maren/.config/awesome/icons/bar/circle-outline-6-icon.png",
        "/home/maren/.config/awesome/icons/bar/circle-outline-7-icon.png",
        "/home/maren/.config/awesome/icons/bar/circle-outline-8-icon.png",
        "/home/maren/.config/awesome/icons/bar/circle-outline-9-icon.png",
    })

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)
    -- Each screen has its own tag table.
    for i = 1, #tags do
         if not tags[i].selected then
             tags[i].screen = s
             tags[i]:view_only()
             break
         end
    end
    s.scratch = awful.tag.add('scratch-' .. s.index, {})
    s.mytaglist = awful.widget.taglist({
       screen = s,
       buttons = taglist_buttons,
       source = function(screen, args) return tags end,
    })
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "bottom", screen = s, bg = "#00000000", height= 25})
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
        },
        { -- Middle
            layout  = wibox.layout.flex.horizontal
        },
        --{ -- Middle
            --layout  = wibox.layout.flex.horizontal
        --},
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            awful.widget.watch('bash -c "/home/maren/.local/bin/collection/sysInfo.sh -watson"', 15),

            wibox.widget.imagebox("/home/maren/.config/awesome/icons/display/1-l.png"),
            clock_widget,
            wibox.widget.imagebox("/home/maren/.config/awesome/icons/display/1-r.png"),

            wibox.widget.imagebox("/home/maren/.config/awesome/icons/display/2-l.png"),
            mem_widget,
            wibox.widget.imagebox("/home/maren/.config/awesome/icons/display/2-r.png"),

            wibox.widget.imagebox("/home/maren/.config/awesome/icons/display/3-l.png"),
            cpu_widget,
            wibox.widget.imagebox("/home/maren/.config/awesome/icons/display/3-r.png"),

            wibox.widget.imagebox("/home/maren/.config/awesome/icons/display/4-l.png"),
            fs_widget,
            wibox.widget.imagebox("/home/maren/.config/awesome/icons/display/4-r.png"),

            wibox.widget.imagebox("/home/maren/.config/awesome/icons/display/5-l.png"),
            battery_status,
            bat_widget,
            wibox.widget.imagebox("/home/maren/.config/awesome/icons/display/5-r.png"),

            wibox.widget.imagebox("/home/maren/.config/awesome/icons/display/6-l.png"),
            testwifistatus,
            net_widget,
            wibox.widget.imagebox("/home/maren/.config/awesome/icons/display/6-r.png"),


            -- s.mylayoutbox,
            -- wibox.widget.systray(),
        },
    }
end)



-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    --awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              --{description = "run prompt", group = "launcher"}),


  awful.key({ modkey }, "d",
    function ()
      awful.util.spawn("rofi -show combi -modi combi -window-thumbnail -theme /home/maren/.config/rofi/rofi.rasi")
  end,
              {description = "run prompt", group = "launcher"}),

  awful.key({ modkey }, "0",
    function ()
      awful.util.spawn("bash /home/maren/.local/bin/collection/shutDown.sh")
  end,

              {description = "Shutdown, Suspend, Reboot", group = "launcher"}),

  awful.key({ modkey }, "p",
    function ()
      awful.util.spawn("bash /home/maren/.local/bin/collection/launcher.sh")
  end, {description = "custom launcher", group = "launcher"}),


  awful.key({ modkey }, "i",
    function ()
      awful.util.spawn("bash /home/maren/.local/bin/collection/dmenuUnicode.sh")
  end, {description = "Unicode menu", group = "launcher"}),



    -- Brightness
    awful.key({ }, "XF86MonBrightnessUp", function () os.execute("xbacklight -inc 10") end,
              {description = "+10%", group = "hotkeys"}),
    awful.key({ }, "XF86MonBrightnessDown", function () os.execute("xbacklight -dec 10") end,
              {description = "-10%", group = "hotkeys"}),
            
    awful.key({ }, "XF86AudioRaiseVolume", function () os.execute("pamixer -i5") end,
              {description = "-10%", group = "hotkeys"}),
    awful.key({ }, "XF86AudioLowerVolume", function () os.execute("pamixer -d5") end,
              {description = "-10%", group = "hotkeys"}),
    awful.key({ }, "XF86AudioMute", function () os.execute("pamixer -t") end,
              {description = "-10%", group = "hotkeys"}),



    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
-- Keys setup
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function () charitable.select_tag(tags[i], awful.screen.focused()) end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function () charitable.toggle_tag(tags[i], awful.screen.focused()) end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Sxiv",
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    { rule_any = {
        class = {
          "xtightvncviewer"},
        name = {
            "Video-Player | Disney+ - qutebrowser"
        }
      }, properties = { opacity = 1 }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },


    -- Set Firefox to always map on the tag named "2" on screen 1.
     { rule = { class = "qutebrowser" },
       properties = { screen = 1, tag = "2" } },
{ rule = { class = "microsoft teams - insiders" },
properties = { screen = 1, tag = "9" } },
{ rule = { class = "Microsoft Teams - Insiders" },
properties = { screen = 1, tag = "9" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

tag.connect_signal("request::screen", function(t)
    t.selected = false
    for s in capi.screen do
        if s ~= t.screen then
            t.screen = s
            return
        end
    end
end)

client.connect_signal("focus", function(c) 
    -- print("the current client changed!", c) 
    awful.client.setmaster(c)
end)


-- work around bugs in awesome 4.0 through 4.3+
-- see https://github.com/awesomeWM/awesome/issues/2780
awful.tag.history.restore = function() end
-- }}}

awful.spawn.with_shell(  "killall compton; sleep 2; compton --config /home/maren/.config/compton/compton.conf &")
awful.spawn.with_shell(  "killall xidelhook; sh /home/maren/.local/bin/collection/xidelhook.sh &")
awful.spawn.with_shell(  "killall udiskie ;  udiskie -t")
-- awful.spawn.with_shell(  "wal --theme /home/maren/.cache/wal/colors.json")
-- awful.spawn.with_shell( "killall redshift; sleep 4 ; redshift -l 48.024395:11.598893 &")
-- awful.spawn.with_shell( "pulseaudio -k; sleep 2; pulseaudio & killall pasystray ; pasystray &")
-- awful.spawn.with_shell( "nm-applet &")
-- awful.spawn.with_shell( "blueman-applet")



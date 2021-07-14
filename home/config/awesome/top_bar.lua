local awful = require("awful")
local beautiful = require("beautiful")
local lain = require("lain")
local vicious = require("vicious")
local wibox = require("wibox")

-- | Contains all the widget components in the top bar | --

local top_bar = {}

-- | Markup | --

local markup = lain.util.markup
local space3 = markup.font("Roboto 3", " ")
local vspace1 = '<span font="Roboto 3"> </span>'

-- | Spacing | --

top_bar.spr = wibox.widget.imagebox(beautiful.spr)
top_bar.spr5px = wibox.widget.imagebox(beautiful.spr5px)

top_bar.widget_display = wibox.widget.imagebox(beautiful.widget_display)
top_bar.widget_display_r = wibox.widget.imagebox(beautiful.widget_display_r)
top_bar.widget_display_l = wibox.widget.imagebox(beautiful.widget_display_l)
top_bar.widget_display_c = wibox.widget.imagebox(beautiful.widget_display_c)

-- | CPU / Temperature | --

local cpu_widget = lain.widget.cpu({
    settings = function()
        widget:set_markup(space3 .. cpu_now.usage .. "%" .. markup.font("Tamsyn 4", " "))
    end
})

top_bar.widget_cpu = wibox.widget.imagebox(beautiful.widget_cpu)
top_bar.cpuwidget = wibox.container.background(cpu_widget.widget)
top_bar.cpuwidget:set_bgimage(beautiful.widget_display)

local tmp_widget = wibox.widget.textbox()
vicious.register(tmp_widget, vicious.widgets.thermal, vspace1 .. "$1°C" .. vspace1, 9, "thermal_zone0")

top_bar.widget_tmp = wibox.widget.imagebox(beautiful.widget_tmp)
top_bar.tmpwidget = wibox.container.background(tmp_widget)
top_bar.tmpwidget:set_bgimage(beautiful.widget_display)

-- | Battery | --

local battery_widget = lain.widget.bat({
    timeout = 60,
    settings = function()
        widget:set_markup(space3 .. bat_now.perc .. "%" .. markup.font("Tamsyn 4", " "))
    end
})

top_bar.widget_bat = wibox.widget.imagebox(beautiful.widget_bat)
top_bar.batwidget = wibox.container.background(battery_widget.widget)
top_bar.batwidget:set_bgimage(beautiful.widget_display)

-- | Bluetooth Battery | --

local headset_battery_widget = awful.widget.watch("bluetooth_battery headset", 60,
    function(widget, stdout)
        stdout = stdout:gsub('%W', '')
        widget:set_markup(space3 .. stdout .. "%" .. markup.font("Tamsyn 4", " "))
    end
)

top_bar.headset_batwidget = wibox.container.background(headset_battery_widget)
top_bar.headset_batwidget:set_bgimage(beautiful.widget_display)

local keyboard_battery_widget = awful.widget.watch("bluetooth_battery keyboard", 60,
    function(widget, stdout)
        stdout = stdout:gsub('%W', '')
        widget:set_markup(space3 .. stdout .. "%" .. markup.font("Tamsyn 4", " "))
    end
)

top_bar.keyboard_batwidget = wibox.container.background(keyboard_battery_widget)
top_bar.keyboard_batwidget:set_bgimage(beautiful.widget_display)

-- | Memory | --

local mem_widget = lain.widget.mem({
    settings = function()
        widget:set_markup(space3 .. mem_now.perc .. "%" .. markup.font("Tamsyn 4", " "))
    end
})

top_bar.widget_mem = wibox.widget.imagebox(beautiful.widget_mem)
top_bar.memwidget = wibox.container.background(mem_widget.widget)
top_bar.memwidget:set_bgimage(beautiful.widget_display)

-- | Filesystem | --

local fs_widget = wibox.widget.textbox()
vicious.register(fs_widget, vicious.widgets.fs, vspace1 .. "${/ avail_gb}GB" .. vspace1, 2)

top_bar.widget_fs = wibox.widget.imagebox(beautiful.widget_fs)
top_bar.fswidget = wibox.container.background(fs_widget)
top_bar.fswidget:set_bgimage(beautiful.widget_display)

-- | Network | --

local net_widgetdl = wibox.widget.textbox()
local net_widgetul = lain.widget.net({
    iface = "wlp0s20f3",
    settings = function()
        widget:set_markup(markup.font("Tamsyn 1", "  ") .. net_now.sent)
        net_widgetdl:set_markup(markup.font("Tamsyn 1", " ") .. net_now.received .. markup.font("Tamsyn 1", " "))
    end
})

top_bar.widget_netdl = wibox.widget.imagebox(beautiful.widget_netdl)
top_bar.netwidgetdl = wibox.container.background(net_widgetdl)
top_bar.netwidgetdl:set_bgimage(beautiful.widget_display)

top_bar.widget_netul = wibox.widget.imagebox(beautiful.widget_netul)
top_bar.netwidgetul = wibox.container.background(net_widgetul.widget)
top_bar.netwidgetul:set_bgimage(beautiful.widget_display)

-- | Clock / Calendar | --

top_bar.widget_clock = wibox.widget.imagebox(beautiful.widget_clock)

top_bar.clockwidget = wibox.container.background(
    wibox.widget.textclock(markup(beautiful.clockgf, space3 .. "%H:%M" .. markup.font("Tamsyn 3", " ")))
)
top_bar.clockwidget:set_bgimage(beautiful.widget_display)

top_bar.datewidget = wibox.container.background(
    wibox.widget.textclock(markup(beautiful.clockgf, space3 .. "%a %d %b" .. markup.font("Tamsyn 3", " ")))
)
top_bar.datewidget:set_bgimage(beautiful.widget_display)

return top_bar

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

-- | CPU / TMP | --

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

return top_bar


                -- [      Power Mode for Awesome 4.1-1      ] --
                -- [          author: scottgreenup          ] --
                -- [     http://github.com/scottgreenup     ] --
                -- [                   --                   ] --
                -- [        Theme credit to barwinco        ] --
                -- [    http://github.com/barwinco/pro      ] --

-- | Author's Commentary | --

-- Barwinco's theme inspired by Luke Bonham - https://github.com/copycat-killer
-- The tiling and window management comes from my old XMonad configuration

-- | To Do List | --

-- sort the taglist on alt-n
-- scratchpad for applications
-- focus when app closes
-- create center-oriented layout, where master is in the center


-- | Libraries | --

local gears = require("gears")
local awful = require("awful")
local assault = require("assault")      -- battery widget
local beautiful = require("beautiful")  -- theme management
local common = require("awful.widget.common")
local lain = require("lain")            -- layouts, widgets, and utilities
local naughty = require("naughty")      -- notification library
local wibox = require("wibox")          -- widget and layout library
local vicious = require("vicious")      -- system widgets

awful.rules = require("awful.rules")

-- | Error handling | --

if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "AwesomeWM: Error With Startup",
        text = awesome.startup_errors
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "AwesomeWM: Runtime error after startup",
            text = err })
        in_error = false
    end)
end

--------------------------------------------------------------------------------
-- Just a quick print function that relies on naughty notification boxes. E.g.:
--      debug_print(string.format("%d\n", myTag.index))
--------------------------------------------------------------------------------
local function debug_print(words)
    naughty.notify({
        preset = naughty.config.presets.normal,
        title = "Debug Message",
        text = words,
        width = 400
    })
end

-- Themes define colours, icons, font and wallpapers.
theme_dir = os.getenv("HOME") .. "/.config/awesome/themes/"
beautiful.init(theme_dir .. "xathereal/theme.lua")

--local theme                                     = {}
--theme.icons                                     = os.getenv("HOME") .. "/.config/awesome/themes/xathereal/icons"
--theme.default_dir                               = require("awful.util").get_themes_dir() .. "default"
--theme.icon_dir                                  = os.getenv("HOME") .. "/.config/awesome/themes/xathereal/icons"
--theme.wallpaper                                 = os.getenv("HOME") .. "/.config/awesome/themes/xathereal/background.png"
--theme.font                                      = "Roboto 7"
--theme.taglist_font                              = "Roboto Condensed Regular 8"
--
--theme.fg_normal                                 = "#FFFFFF"
--theme.fg_focus                                  = "#0099CC"
--theme.bg_focus                                  = "#303030"
--theme.bg_normal                                 = "#242424"
--theme.fg_urgent                                 = "#CC9393"
--theme.bg_urgent                                 = "#006B8E"
--theme.border_width                              = 3
--theme.border_normal                             = "#252525"
--theme.border_focus                              = "#0099CC"
--
--theme.taglist_fg_focus                          = "#FFFFFF"
--theme.tasklist_bg_normal                        = "#222222"
--theme.tasklist_fg_focus                         = "#4CB7DB"
--theme.menu_height                               = 20
--theme.menu_width                                = 160
--theme.menu_icon_size                            = 32
--theme.awesome_icon                              = theme.icon_dir .. "/awesome_icon_white.png"
--theme.awesome_icon_launcher                     = theme.icon_dir .. "/awesome_icon.png"
--theme.taglist_squares_sel                       = theme.icon_dir .. "/square_sel.png"
--theme.taglist_squares_unsel                     = theme.icon_dir .. "/square_unsel.png"
--theme.spr_small                                 = theme.icon_dir .. "/spr_small.png"
--theme.spr_very_small                            = theme.icon_dir .. "/spr_very_small.png"
--theme.spr_right                                 = theme.icon_dir .. "/spr_right.png"
--theme.spr_bottom_right                          = theme.icon_dir .. "/spr_bottom_right.png"
--theme.spr_left                                  = theme.icon_dir .. "/spr_left.png"
--theme.bar                                       = theme.icon_dir .. "/bar.png"
--theme.bottom_bar                                = theme.icon_dir .. "/bottom_bar.png"
--theme.mpdl                                      = theme.icon_dir .. "/mpd.png"
--theme.mpd_on                                    = theme.icon_dir .. "/mpd_on.png"
--theme.prev                                      = theme.icon_dir .. "/prev.png"
--theme.nex                                       = theme.icon_dir .. "/next.png"
--theme.stop                                      = theme.icon_dir .. "/stop.png"
--theme.pause                                     = theme.icon_dir .. "/pause.png"
--theme.play                                      = theme.icon_dir .. "/play.png"
--theme.clock                                     = theme.icon_dir .. "/clock.png"
--theme.calendar                                  = theme.icon_dir .. "/cal.png"
--theme.cpu                                       = theme.icon_dir .. "/cpu.png"
--theme.net_up                                    = theme.icon_dir .. "/net_up.png"
--theme.net_down                                  = theme.icon_dir .. "/net_down.png"
--theme.layout_tile                               = theme.icon_dir .. "/tile.png"
--theme.layout_tileleft                           = theme.icon_dir .. "/tileleft.png"
--theme.layout_tilebottom                         = theme.icon_dir .. "/tilebottom.png"
--theme.layout_tiletop                            = theme.icon_dir .. "/tiletop.png"
--theme.layout_fairv                              = theme.icon_dir .. "/fairv.png"
--theme.layout_fairh                              = theme.icon_dir .. "/fairh.png"
--theme.layout_spiral                             = theme.icon_dir .. "/spiral.png"
--theme.layout_dwindle                            = theme.icon_dir .. "/dwindle.png"
--theme.layout_max                                = theme.icon_dir .. "/max.png"
--theme.layout_fullscreen                         = theme.icon_dir .. "/fullscreen.png"
--theme.layout_magnifier                          = theme.icon_dir .. "/magnifier.png"
--theme.layout_floating                           = theme.icon_dir .. "/floating.png"
--theme.tasklist_plain_task_name                  = true
--theme.tasklist_disable_icon                     = true
--theme.useless_gap                               = 4
--
--theme.musicplr = string.format("%s -e ncmpcpp", awful.util.terminal)

local home   = os.getenv("HOME")
local exec   = function (s) awful.util.spawn(s, false) end
local shexec = awful.util.spawn_with_shell
local modkey = "Mod1"

-- This is used later as the default terminal and editor to run.
programs = {}
programs["browser"]     = "chromium"
programs["terminal"]    = "urxvt"
programs["lock"]        = "xscreensaver-command --lock"
programs["randr"]       = "arandr"
programs["editor"]      = os.getenv("EDITOR") or "vim"
programs["editor_cmd"]  = programs["terminal"] .. " -e " .. programs["editor"]

local layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}

-- | Tags | --

awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, 1, layouts[1])
shared_tag_list = screen[1].tags

-- Ensure every screen has a tag, and a tag that is activated
for s = 2, screen.count() do
    shared_tag_list[s].screen = s
    awful.tag.viewnone(screen[s])
    awful.tag.viewmore({shared_tag_list[s]})
end

-- | Screen ordering | --

-- This is for multi-monitor systems. Horizontal and vertical.
-- This chunk works out where the screens are and does a logical grid of them.
-- i.e. rows[2][1] is the second row of screens, and the left most one
-- TODO order them from left to right, they can be in a weird order..

rows = {}
curr_y = 0
curr_screen = -1
row = {}
checked = {}

while curr_y < (1600 * 3 + 1) do
    if curr_screen > 0 then
        gg = screen[curr_screen].geometry
        if curr_y >= (gg.y + gg.height) then
            curr_screen = -1

            -- TODO sort row by x ascending

            table.insert(rows, row)
            row = {}
        end
    end

    for s = 1, screen.count() do
        if not checked[s] then
            g = screen[s].geometry

            if curr_y == g.y then
                if curr_screen == -1 then
                    curr_screen = s
                    table.insert(row, s)
                    checked[s] = true
                else
                    gg = screen[curr_screen].geometry
                    if g.y >= gg.y and g.y < (gg.y + gg.height) then
                        table.insert(row, s)
                        checked[s] = true
                    end
                end
            end
        end
    end
    curr_y = curr_y + 1
end

-- | Menu | --

menu_main = awful.menu({
    items = {
        { "Terminal",           programs["terminal"] },
        { "------------------", "" },
        { "Power Off",          "sudo poweroff" },
        { "Reboot",             "sudo reboot" },
        { "------------------", "" },
        { "Restart Awesome",    awesome.restart },
        { "Quit Awesome",       awesome.quit },
    }
})


menu_launcher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = menu_main
})

-- | Markup | --

local markup = lain.util.markup
local space3 = markup.font("Roboto 3", " ")
local space4 = markup.font("Roboto 4", " ")
local vspace1 = '<span font="Roboto 3"> </span>'
local vspace2 = '<span font="Roboto 3">  </span>'

-- | Widgets | --

--local sep_vertical = wibox.widget.imagebox(theme.bottom_bar)

spr = wibox.widget.imagebox()
spr:set_image(beautiful.spr)
spr4px = wibox.widget.imagebox()
spr4px:set_image(beautiful.spr4px)
spr5px = wibox.widget.imagebox()
spr5px:set_image(beautiful.spr5px)

widget_display = wibox.widget.imagebox()
widget_display:set_image(beautiful.widget_display)
widget_display_r = wibox.widget.imagebox()
widget_display_r:set_image(beautiful.widget_display_r)
widget_display_l = wibox.widget.imagebox()
widget_display_l:set_image(beautiful.widget_display_l)
widget_display_c = wibox.widget.imagebox()
widget_display_c:set_image(beautiful.widget_display_c)

-- | CPU / TMP | --

cpu_widget = lain.widget.cpu({
    settings = function()
        widget:set_markup(space3 .. cpu_now.usage .. "%" .. markup.font("Tamsyn 4", " "))
    end
})

widget_cpu = wibox.widget.imagebox()
widget_cpu:set_image(beautiful.widget_cpu)
cpuwidget = wibox.widget.background()
cpuwidget:set_widget(cpu_widget.widget)
cpuwidget:set_bgimage(beautiful.widget_display)

tmp_widget = wibox.widget.textbox()
vicious.register(tmp_widget, vicious.widgets.thermal, vspace1 .. "$1°C" .. vspace1, 9, "thermal_zone0")

widget_tmp = wibox.widget.imagebox()
widget_tmp:set_image(beautiful.widget_tmp)
tmpwidget = wibox.widget.background()
tmpwidget:set_widget(tmp_widget)
tmpwidget:set_bgimage(beautiful.widget_display)

-- | MEM | --

mem_widget = lain.widget.mem({
    settings = function()
        widget:set_markup(space3 .. mem_now.used .. "MB" .. markup.font("Tamsyn 4", " "))
    end
})

widget_mem = wibox.widget.imagebox()
widget_mem:set_image(beautiful.widget_mem)
memwidget = wibox.widget.background()
memwidget:set_widget(mem_widget.widget)
memwidget:set_bgimage(beautiful.widget_display)

-- | FS | --

fs_widget = wibox.widget.textbox()
vicious.register(fs_widget, vicious.widgets.fs, vspace1 .. "${/ avail_gb}GB" .. vspace1, 2)

widget_fs = wibox.widget.imagebox()
widget_fs:set_image(beautiful.widget_fs)
fswidget = wibox.widget.background()
fswidget:set_widget(fs_widget)
fswidget:set_bgimage(beautiful.widget_display)

-- | NET | --

net_widgetdl = wibox.widget.textbox()
net_widgetul = lain.widget.net({
    iface = "wlp2s0",
    settings = function()
        widget:set_markup(markup.font("Tamsyn 1", "  ") .. net_now.sent)
        net_widgetdl:set_markup(markup.font("Tamsyn 1", " ") .. net_now.received .. markup.font("Tamsyn 1", " "))
    end
})

widget_netdl = wibox.widget.imagebox()
widget_netdl:set_image(beautiful.widget_netdl)
netwidgetdl = wibox.widget.background()
netwidgetdl:set_widget(net_widgetdl)
netwidgetdl:set_bgimage(beautiful.widget_display)

widget_netul = wibox.widget.imagebox()
widget_netul:set_image(beautiful.widget_netul)
netwidgetul = wibox.widget.background()
netwidgetul:set_widget(net_widgetul.widget)
netwidgetul:set_bgimage(beautiful.widget_display)

-- | Clock / Calendar | --

mytextclock    = awful.widget.textclock(
    markup(
        beautiful.clockgf,
        space3 .. "%H:%M" .. markup.font("Tamsyn 3", " ")))
mytextcalendar = awful.widget.textclock(
    markup(beautiful.clockgf, space3 .. "%a %d %b"))

widget_clock = wibox.widget.imagebox()
widget_clock:set_image(beautiful.widget_clock)

clockwidget = wibox.widget.background()
clockwidget:set_widget(mytextclock)
clockwidget:set_bgimage(beautiful.widget_display)

local index = 1
local loop_widgets = { mytextclock, mytextcalendar }
local loop_widgets_icons = { beautiful.widget_clock, beautiful.widget_cal }

clockwidget:buttons(awful.util.table.join(awful.button({}, 1,
    function ()
        index = index % #loop_widgets + 1
        clockwidget:set_widget(loop_widgets[index])
        widget_clock:set_image(loop_widgets_icons[index])
    end)))

-- | Task List | --

mytasklist = {}
mytasklist.buttons = awful.util.table.join(
    awful.button({ }, 1,
        function (c)
            if c == client.focus then
                c.minimized = true
            else
                -- Without this, the following
                -- :isvisible() makes no sense
                c.minimized = false
                if not c:isvisible() then
                    awful.tag.viewonly(c:tags()[1])
                end
                -- This will also un-minimize
                -- the client, if needed
                client.focus = c
                c:raise()
            end
        end),
    awful.button({ }, 3,
        function ()
            if instance then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({
                    theme = { width = 250 }
                })
            end
        end),
    awful.button({ }, 4,
        function ()
            awful.client.focus.byidx(1)
            if client.focus then client.focus:raise() end
        end),
    awful.button({ }, 5,
        function ()
             awful.client.focus.byidx(-1)
             if client.focus then client.focus:raise() end
        end
    )
)

-- Create a wibox for each screen and add it
mywibox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
    awful.button({ }, 1, awful.tag.viewonly),
    awful.button({ modkey }, 1, awful.client.movetotag),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, awful.client.toggletag),
    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)


for s = 1, screen.count() do

    if beautiful.wallpaper then
        gears.wallpaper.maximized(beautiful.wallpaper, s)
    end

    mytaglist[s] = awful.widget.taglist(
        s, awful.widget.taglist.filter.all, mytaglist.buttons)

    mytasklist[s] = awful.widget.tasklist(
        s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibar({
        position = "top", screen = s, height = 22 })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    --left_layout:add(mylauncher)
    left_layout:add(spr5px)
    left_layout:add(mytaglist[s])
    left_layout:add(spr5px)

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then
        right_layout:add(spr)
        right_layout:add(spr5px)
        right_layout:add(wibox.widget.systray())
        right_layout:add(spr5px)
    end

    right_layout:add(spr)

    right_layout:add(widget_cpu)
    right_layout:add(widget_display_l)
    right_layout:add(cpuwidget)
    right_layout:add(widget_display_r)
    right_layout:add(widget_display_l)
    right_layout:add(tmpwidget)
    right_layout:add(widget_tmp)
    right_layout:add(widget_display_r)
    right_layout:add(spr5px)

    right_layout:add(spr)

    right_layout:add(widget_mem)
    right_layout:add(widget_display_l)
    right_layout:add(memwidget)
    right_layout:add(widget_display_r)
    right_layout:add(spr5px)

    right_layout:add(spr)

    right_layout:add(widget_fs)
    right_layout:add(widget_display_l)
    right_layout:add(fswidget)
    right_layout:add(widget_display_r)
    right_layout:add(spr5px)

    right_layout:add(spr)

    right_layout:add(widget_netdl)
    right_layout:add(widget_display_l)
    right_layout:add(netwidgetdl)
    right_layout:add(widget_display_c)
    right_layout:add(netwidgetul)
    right_layout:add(widget_display_r)
    right_layout:add(widget_netul)

    right_layout:add(spr)

    right_layout:add(widget_clock)
    right_layout:add(widget_display_l)
    right_layout:add(clockwidget)
    right_layout:add(widget_display_r)
    right_layout:add(spr5px)

    right_layout:add(spr)

    --right_layout:add(gapwidget)
    --right_layout:add(disk_widget)
    --right_layout:add(gapwidget)
    --right_layout:add(uptwidget)
    --right_layout:add(gapwidget)
    --right_layout:add(memwidget)
    --right_layout:add(gapwidget)

    --right_layout:add(sep_vertical)
    --right_layout:add(cpu_icon)
    --right_layout:add(cpu_widget)
    --right_layout:add(sep_vertical)
    --right_layout:add(calendar_icon)
    --right_layout:add(calendar_widget)
    --right_layout:add(sep_vertical)
    --right_layout:add(clock_icon)
    --right_layout:add(clock_widget)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

function focus_on_screen(x, y, rows)

    if #rows == 1 and y == 2 then
        y = 1
    end

    if y <= #rows then
        local row = rows[y]
        if x <= #row then
            s = row[x]
            awful.screen.focus(s)
        end
    end

end

function spawn_program(program)
    awful.spawn(program, {
        --tag=screen[awful.screen.focused({client=true})].selected_tag
        tag=mouse.screen.selected_tag
    })
end

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

function move_tag_to_screen(_tag, _screen_index)
    awful.tag.setproperty(_tag, "hide", true)
    _tag.screen = _screen_index
    awful.tag.setproperty(_tag, "hide", false)
end

function force_focus(_screen)
    awful.screen.focus(_screen)
    if #_screen.clients > 0 then
        c = _screen.clients[1]
        client.focus = c
        c:raise()
    end
end

--local scratchpad_scr = screen.fake_add(0, 0, 1920, 1080)
--local spotify_tag = awful.tag.add(
--    "spotify", {
--        screen = scratchpad_scr.index,
--        layout = awful.layout.suit.floating
--    }
--)
--
----awful.spawn("arandr", {tag=spotify_tag})
--
--debug_print(string.format("%d\n", spotify_tag.index))
--spotify_tag.selected = false

-- Changing default notification size
naughty.config.defaults['icon_size'] = 90
naughty.config.defaults['height'] = 100
naughty.config.defaults['width'] = 300

-- onkey we need to move_tag_to_screen that is focused, then select that client
-- offkey we need to move_tag_to_scratchpad, then select another client

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),

    awful.key({ modkey,           }, "w", function () focus_on_screen(3, 1, rows) end),
    awful.key({ modkey,           }, "e", function () focus_on_screen(1, 1, rows) end),
    awful.key({ modkey,           }, "r", function () focus_on_screen(2, 1, rows) end),

    awful.key({ modkey,           }, "s", function () focus_on_screen(1, 2, rows) end),
    awful.key({ modkey,           }, "d", function () focus_on_screen(2, 2, rows) end),
    awful.key({ modkey,           }, "f", function () focus_on_screen(3, 2, rows) end),

    -- Standard program
    awful.key({ "Mod4",           }, "w", function ()       spawn_program(programs["browser"]) end),
    awful.key({ modkey, "Shift"   }, "Return", function ()  spawn_program(programs["terminal"]) end),
    awful.key({ "Mod4",           }, "l", function ()       spawn_program(programs["lock"]) end),
    awful.key({ "Mod4",           }, "a", function ()       spawn_program(programs["randr"]) end),

    -- Awesome Control
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    -- Window Control
    awful.key({ modkey,           }, "l", function () awful.tag.incmwfact( 0.03) end),
    awful.key({ modkey,           }, "h", function () awful.tag.incmwfact(-0.03) end),
    awful.key({ modkey,           }, ",", function () awful.tag.incnmaster( 1) end),
    awful.key({ modkey,           }, ".", function () awful.tag.incnmaster(-1) end),
    awful.key({ modkey, "Control" }, "h", function () awful.tag.incncol( 1) end),
    awful.key({ modkey, "Control" }, "l", function () awful.tag.incncol(-1) end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts, 1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Audio Control
    awful.key({}, "XF86AudioRaiseVolume", function()
        awful.util.spawn("amixer -M set Master 5%+")
    end),
    awful.key({}, "XF86AudioLowerVolume", function()
        awful.util.spawn("amixer -M set Master 5%-")
    end),
    awful.key({}, "XF86AudioMute", function()
        awful.util.spawn("amixer -M sset Master toggle")
    end),

    -- Brightness
    awful.key({}, "XF86MonBrightnessUp", function()
        awful.util.spawn("xbacklight -inc 10")
    end),
    awful.key({}, "XF86MonBrightnessDown", function()
        awful.util.spawn("xbacklight -dec 10")
    end),

    -- DMenu2
    awful.key({ modkey }, "p", function()
        scr = awful.screen.focused({client=true})

        local scrgeom = screen[scr].workarea
        local command = "dmenu_custom"
        command = command .. " " .. tostring(scrgeom.x)
        command = command .. " " .. tostring(scrgeom.y)
        command = command .. " " .. tostring(scrgeom.width)
        command = command .. " " .. tostring(scrgeom.height)
        awful.util.spawn(command)
    end)
)

function move_client_to_screen(c, x, y)
    if #rows == 1 and y == 2 then
        y = 1
    end

    if y <= #rows then
        local row = rows[y]
        if x <= #row then
            s = row[x]
            awful.client.movetoscreen(c, s)
        end
    end
end

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey,           }, "t",      awful.client.floating.toggle                     ),
    awful.key({ modkey,           }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey, "Shift"   }, "w", function (c) move_client_to_screen(c, 1, 1) end),
    awful.key({ modkey, "Shift"   }, "e", function (c) move_client_to_screen(c, 2, 1) end),
    awful.key({ modkey, "Shift"   }, "r", function (c) move_client_to_screen(c, 3, 1) end),
    awful.key({ modkey, "Shift"   }, "s", function (c) move_client_to_screen(c, 1, 2) end),
    awful.key({ modkey, "Shift"   }, "d", function (c) move_client_to_screen(c, 2, 2) end),
    awful.key({ modkey, "Shift"   }, "f", function (c) move_client_to_screen(c, 3, 2) end),
    awful.key({ modkey,           }, "y",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
        function ()

            -- I want to bring new_tag to focus on target_scr
            local new_tag = shared_tag_list[i]
            local target_scr = awful.screen.focused()

            if new_tag.selected and (new_tag.screen.index == target_scr.index) then
                return

            elseif not new_tag.selected and (new_tag.screen.index == target_scr.index) then
                awful.tag.viewnone(target_scr)
                awful.tag.viewmore({new_tag})
                force_focus(target_scr)

            elseif not new_tag.selected and (new_tag.screen.index ~= target_scr.index) then
                other_scr = new_tag.screen
                other_tag = other_scr.selected_tag

                move_tag_to_screen(new_tag, target_scr.index)
                awful.tag.viewnone(target_scr)
                awful.tag.viewnone(other_scr)
                awful.tag.viewmore({new_tag, other_tag})
                force_focus(target_scr)

            elseif new_tag.selected and (new_tag.screen.index ~= target_scr.index) then

                other_scr = new_tag.screen
                curr_tag = target_scr.selected_tag

                move_tag_to_screen(new_tag, target_scr.index)
                awful.tag.viewnone(target_scr)

                -- move focused screen tag to other screen
                if curr_tag then
                    move_tag_to_screen(curr_tag, other_scr.index)
                    awful.tag.viewnone(other_scr)
                    awful.tag.viewmore({curr_tag})
                end

                awful.tag.viewmore({new_tag})
                force_focus(target_scr)
            end

        end),

    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
    function ()
        if client.focus then
            local tag = shared_tag_list[i]
            if tag then
                client.focus:move_to_tag(tag)
            end
        end
    end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {

    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            size_hints_honor = false,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons
        }
    },

    {
        rule_any = {
            class = {
                "Arandr",
                "gimp",
                "keepassx2",
                "Keepassx2"
            }
        },
        properties = { floating = true }
    },
}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

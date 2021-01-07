
                -- [      Power Mode for Awesome 4.3-2      ] --
                -- [          Author: ejwmoreau             ] --
                -- [     http://github.com/ejwmoreau        ] --
                -- [                   --                   ] --
                -- [  Customisation credit to scottgreenup  ] --
                -- [     http://github.com/scottgreenup     ] --
                -- [                   --                   ] --
                -- [        Theme credit to barwinco        ] --
                -- [    http://github.com/barwinco/pro      ] --

-- | Author's Commentary | --

-- Most of the config was implemented by scottgreenup
-- Barwinco's pro-dark theme inspired by Luke Bonham - https://github.com/lcpz
-- Tiling and window management comes from my old XMonad configuration

-- | TODO List | --

-- sort the taglist after a screen gets disconnected
-- scratchpad for applications: https://github.com/notnew/awesome-scratch
-- improve focus when app closes

-- | Libraries | --

local gears = require("gears")
local awful = require("awful")
local assault = require("assault")      -- battery widget
local beautiful = require("beautiful")  -- theme management
local common = require("awful.widget.common")
local lain = require("lain")
local naughty = require("naughty")      -- notification library
local wibox = require("wibox")          -- widget and layout library
local vicious = require("vicious")      -- system widgets

awful.rules = require("awful.rules")

-- TODO: Maybe move this into a theme.lua or something?
-- Needs to load before `top_bar`
-- Themes define colours, icons, font and wallpapers.
theme_dir = os.getenv("HOME") .. "/.config/awesome/themes/"
beautiful.init(theme_dir .. "pro-dark/theme.lua")

-- | Personal Libraries | --

local helper = require("helper")
local key_bindings = require("key_bindings")
local signal = require("signal")
local top_bar = require("top_bar")

-- | Error handling | --

-- Errors with starting up
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "AwesomeWM: Error With Startup",
        text = awesome.startup_errors
    })
end

-- Errors after startup
awesome.connect_signal("debug::error", function (err)
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "AwesomeWM: Runtime error after startup",
        text = err
    })
end)

--------------------------------------------------------------------------------
-- Just a quick print function that relies on naughty notification boxes. E.g.:
--      debug_print(string.format("%d\n", myTag.index))
--------------------------------------------------------------------------------
local function debug_print(words)
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Debug Message",
        text = words,
        width = 400
    })
end

-- | Notifications | --

-- Customise some notification parameters
naughty.config.notify_callback = function(args)

    if args.timeout == nil or args.timeout < theme.notification_min_timeout then
        args.timeout = theme.notification_min_timeout
    end

    if args.icon then
        if args.icon_size == nil or args.icon_size > theme.notification_max_icon_size then
            args.icon_size = theme.notification_max_icon_size
        end
    end

    return args
end

-- | Global Variables | --

local modkey = key_bindings.modkey

-- This is used later as the default terminal and editor to run.
programs = {
    ["audio"]       = "pavucontrol",
    --["browser"]     = "firefox",
    ["browser"]     = "chromium",
    ["terminal"]    = "urxvt",
    ["lock"]        = "i3lock -c 000000 -f",
    ["randr"]       = "arandr",
    ["editor"]      = os.getenv("EDITOR") or "vim",
    ["screenshot"]  = "( flameshot & ) && ( sleep 0.2s && flameshot gui -p ~/shots )"
}

layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
    lain.layout.centerwork_leftright,
    awful.layout.suit.max.fullscreen,
}

-- | Tags | --

awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, 1, layouts[1])
shared_tag_list = screen[1].tags

-- Ensure every screen has a tag, and a tag that is activated
for s = 1, screen.count() do
    shared_tag_list[s].screen = s
    awful.tag.viewnone(screen[s])
    awful.tag.viewmore({shared_tag_list[s]})
end

-- | Screen ordering | --

screen_map = {}
table.insert(screen_map, 1)

-- Work out the ordering for alt-s, alt-d, and alt-f
for i = 2, screen.count() do
    gi = screen[i].geometry
    inserted = false

    for j = 1, #screen_map do
        gj = screen[screen_map[j]].geometry

        if gj.x > gi.x then
            table.insert(screen_map, j, i)
            inserted = true
            break
        end
    end

    if inserted == false then
        table.insert(screen_map, i)
    end
end

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
                    c:tags()[1]:view_only()
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


mywibox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, awful.client.movetotag),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, awful.client.toggletag),
    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)

-- TODO: Move this to signal.lua when setup_screen() moves to screen.lua
-- On new screen added: The first unused tag will be moved to the new screen
screen.connect_signal("added", function()
    -- Find the new screen that doesn't have a tag yet
    local new_screen = nil
    for s in screen do
        if next(s.tags) == nil then
            new_screen = s
            break
        end
    end

    setup_screen(new_screen)

    -- Find a tag that isn't currently selected, and move it to the new screen
    for _, t in pairs(root.tags()) do
        if not t.selected then
            helper.move_tag_to_screen(t, new_screen.index)
            return
        end
    end
end)

-- Setup wibox, layout, wallpaper, etc for a particular screen
function setup_screen(s)

    helper.set_wallpaper(s)

    mytaglist[s] = awful.widget.taglist(
        s, awful.widget.taglist.filter.all, mytaglist.buttons)

    mytasklist[s] = awful.widget.tasklist(
        s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibar({
        position = "top", screen = s, height = beautiful.menu_height })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(top_bar.spr5px)
    left_layout:add(mytaglist[s])
    left_layout:add(top_bar.spr5px)

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then
        right_layout:add(top_bar.spr)
        right_layout:add(top_bar.spr5px)
        right_layout:add(wibox.widget.systray())
        right_layout:add(top_bar.spr5px)
    end

    right_layout:add(top_bar.spr)

    right_layout:add(top_bar.widget_cpu)
    right_layout:add(top_bar.widget_display_l)
    right_layout:add(top_bar.cpuwidget)
    right_layout:add(top_bar.widget_display_c)
    right_layout:add(top_bar.tmpwidget)
    right_layout:add(top_bar.widget_tmp)
    right_layout:add(top_bar.widget_display_r)
    right_layout:add(top_bar.spr5px)

    right_layout:add(top_bar.spr)

    right_layout:add(top_bar.widget_mem)
    right_layout:add(top_bar.widget_display_l)
    right_layout:add(top_bar.memwidget)
    right_layout:add(top_bar.widget_display_r)
    right_layout:add(top_bar.spr5px)

    right_layout:add(top_bar.spr)

    right_layout:add(top_bar.widget_bat)
    right_layout:add(top_bar.widget_display_l)
    right_layout:add(top_bar.batwidget)
    right_layout:add(top_bar.widget_display_r)
    right_layout:add(top_bar.spr5px)

    right_layout:add(top_bar.spr)

    right_layout:add(top_bar.widget_fs)
    right_layout:add(top_bar.widget_display_l)
    right_layout:add(top_bar.fswidget)
    right_layout:add(top_bar.widget_display_r)
    right_layout:add(top_bar.spr5px)

    right_layout:add(top_bar.spr)

    right_layout:add(top_bar.widget_netdl)
    right_layout:add(top_bar.widget_display_l)
    right_layout:add(top_bar.netwidgetdl)
    right_layout:add(top_bar.widget_display_c)
    right_layout:add(top_bar.netwidgetul)
    right_layout:add(top_bar.widget_display_r)
    right_layout:add(top_bar.widget_netul)

    right_layout:add(top_bar.spr)

    right_layout:add(top_bar.widget_clock)
    right_layout:add(top_bar.widget_display_l)
    right_layout:add(top_bar.datewidget)
    right_layout:add(top_bar.widget_display_c)
    right_layout:add(top_bar.clockwidget)
    right_layout:add(top_bar.widget_display_r)
    right_layout:add(top_bar.spr5px)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end


-- Create a wibox for each screen and add it
for s = 1, screen.count() do
    setup_screen(s)
end

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

globalkeys = key_bindings.globalkeys

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",       function (c) c.fullscreen = not c.fullscreen end),
    awful.key({ modkey, "Shift"   }, "c",       function (c) helper.kill_select(c) end),
    awful.key({ modkey,           }, "t",       awful.client.floating.toggle ),
    awful.key({ modkey,           }, "Return",  function (c) c:swap(awful.client.getmaster()) end),

    -- This is useful if for debugging, when you want to know what Awesome is
    -- doing with a window.
    awful.key({ modkey, "Control" }, "s",       function (c)

        -- WTF IS THIS STUPID MAXAMIZED BULLSHIT

        c.maximized = false
        c.minimized = false
        c.maximized_horizontal = false
        c.maximized_vertical = false

        debug_print(
            string.format("window = %s\n", c.window) ..
            string.format("name = %s\n", c.name) ..
            string.format("skip_taskbar = %s\n", tostring(c.skip_taskbar)) ..
            string.format("type = %s\n", c.type) ..
            string.format("class = %s\n", c.class) ..
            string.format("instance = %s\n", c.instance) ..
            string.format("pid = %d\n", c.pid) ..
            string.format("role = %s\n", c.role) ..
            string.format("machine = %s\n", c.machine) ..
            string.format("icon_name = %s\n", c.icon_name) ..
            string.format("hidden = %s\n", tostring(c.hidden)) ..
            string.format("minimized = %s\n", tostring(c.minimized)) ..
            string.format("size_hints_honor = %s\n", tostring(c.size_hints_honor)) ..
            string.format("urgent = %s\n", tostring(c.urgent)) ..
            string.format("ontop = %s\n", tostring(c.ontop)) ..
            string.format("above = %s\n", tostring(c.above)) ..
            string.format("below = %s\n", tostring(c.below)) ..
            string.format("fullscreen = %s\n", tostring(c.fullscreen)) ..
            string.format("maximized = %s\n", c.maximized) ..
            string.format("maximized_horizontal = %s\n", c.maximized_horizontal) ..
            string.format("maximized_vertical = %s\n", c.maximized_vertical) ..
            string.format("sticky = %s\n", tostring(c.sticky)) ..
            string.format("modal = %s\n", tostring(c.modal)) ..
            string.format("focusable = %s\n", tostring(c.focusable)) ..
            string.format("marked = %s\n", tostring(c.marked)) ..
            string.format("floating = %s\n", tostring(c.floating)) ..
            string.format("dockable = %s\n", tostring(c.dockable))
        )
    end),
    awful.key({ modkey, "Shift"   }, "s",       function (c) helper.move_client_to_screen(c, 1, screen_map) end),
    awful.key({ modkey, "Shift"   }, "d",       function (c) helper.move_client_to_screen(c, 2, screen_map) end),
    awful.key({ modkey, "Shift"   }, "f",       function (c) helper.move_client_to_screen(c, 3, screen_map) end),
    awful.key({ modkey,           }, "y",       function (c) c.ontop = not c.ontop end),
    awful.key({ modkey,           }, "n",
        function (c)
            c.minimized = true
            c.maximized = false
            helper.select_next(c)
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
    awful.key({ modkey }, "#" .. i + 9, function ()

        -- I want to bring new_tag to focus on target_scr
        local new_tag = shared_tag_list[i]
        local target_scr = awful.screen.focused()

        if new_tag.selected and (new_tag.screen.index == target_scr.index) then
            return

        elseif not new_tag.selected and (new_tag.screen.index == target_scr.index) then
            awful.tag.viewnone(target_scr)
            awful.tag.viewmore({new_tag})
            helper.force_focus(target_scr)

        elseif not new_tag.selected and (new_tag.screen.index ~= target_scr.index) then
            other_scr = new_tag.screen
            other_tag = other_scr.selected_tag

            -- TODO can other_tag be nil?

            helper.move_tag_to_screen(new_tag, target_scr.index)
            awful.tag.viewnone(target_scr)
            awful.tag.viewnone(other_scr)
            awful.tag.viewmore({new_tag, other_tag})
            helper.force_focus(target_scr)

        elseif new_tag.selected and (new_tag.screen.index ~= target_scr.index) then

            other_scr = new_tag.screen
            curr_tag = target_scr.selected_tag

            helper.move_tag_to_screen(new_tag, target_scr.index)
            awful.tag.viewnone(target_scr)

            -- move focused screen tag to other screen
            if curr_tag then
                helper.move_tag_to_screen(curr_tag, other_scr.index)
                awful.tag.viewnone(other_scr)
                awful.tag.viewmore({curr_tag})
            end

            awful.tag.viewmore({new_tag})
            helper.force_focus(target_scr)
        end

        helper.sort_tags()
    end),

    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9, function ()
        if client.focus then
            local tag = shared_tag_list[i]
            if tag then
                client.focus:move_to_tag(tag)
            end
        end
    end))
end

clientbuttons = awful.util.table.join(
    awful.button({        }, 1, function (c) client.focus = c end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize)
)

root.keys(globalkeys)

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
                "gimp",
                "Keepassx2", "keepassx2",
            }
        },
        properties = { floating = true }
    },

    {
        rule_any = {
            class = {
                "Arandr", "arandr",
                "Pavucontrol", "pavucontrol"
            }
        },
        properties = { floating = true },

        -- TODO make this play nice with larger or smaller resolutions
        callback = function(c)
            helper.client_move_on_screen(c, 100, 100)
            helper.client_resize(c, 1920, 1080)
        end
    },

    {
        rule_any = {
            name = { "win.*", },
        },
        properties = { focusable = false, ontop = true }
    },

    {
        rule_any = {
            class = { "zoom" }
        },
        properties = { tag = "8", above = false }
    }
}

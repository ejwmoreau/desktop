local awful = require("awful")
local helper = require("helper")

local key_bindings = {}

local modkey = "Mod4"
key_bindings.modkey = modkey

key_bindings.globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "j", function ()
        awful.client.focus.byidx( 1)
        if client.focus then
            client.focus:raise()
        end
    end),
    awful.key({ modkey,           }, "k", function ()
        awful.client.focus.byidx(-1)
        if client.focus then
            client.focus:raise()
        end
    end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),

    awful.key({ modkey,           }, "s", function () helper.focus_on_screen(1, screen_map) end),
    awful.key({ modkey,           }, "d", function () helper.focus_on_screen(2, screen_map) end),
    awful.key({ modkey,           }, "f", function () helper.focus_on_screen(3, screen_map) end),
    awful.key({ modkey, "Shift"   }, "t", function () helper.reset_to_primary() end),

    -- Standard programs
    awful.key({ modkey,           }, "w", function () helper.spawn_program(programs["browser"]) end),

    awful.key({ modkey, "Shift"   }, "Return", function ()
        -- Make sure our X server resource database is up-to-date, that way our
        -- terminal will have the latest settings configured in ~/.Xresources
        helper.spawn_program("xrdb ~/.Xresources")
        helper.spawn_program(programs["terminal"])
    end),

    awful.key({ modkey,           }, "l", function () helper.spawn_program(programs["lock"]) end),
    awful.key({ modkey,           }, "a", function () helper.spawn_program(programs["randr"]) end),
    awful.key({ modkey,           }, "u", function () helper.spawn_program(programs["audio"]) end),
    awful.key({                   }, "Print", function () awful.spawn.with_shell(programs["screenshot"]) end),

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
    awful.key({                   }, "XF86AudioRaiseVolume", function() helper.spawn_program("pamixer -i 5") end),
    awful.key({                   }, "XF86AudioLowerVolume", function() helper.spawn_program("pamixer -d 5") end),
    awful.key({                   }, "XF86AudioMute",        function() helper.spawn_program("pamixer -t") end),

    -- Music Control
    awful.key({                   }, "XF86AudioPlay",  function() helper.spawn_program("playerctl play-pause") end),
    awful.key({                   }, "XF86AudioPause", function() helper.spawn_program("playerctl play-pause") end),
    awful.key({                   }, "XF86AudioNext",  function() helper.spawn_program("playerctl next") end),
    awful.key({                   }, "XF86AudioPrev",  function() helper.spawn_program("playerctl previous") end),

    -- Brightness
    awful.key({                   }, "XF86MonBrightnessUp",   function() helper.spawn_program("brightness -inc") end),
    awful.key({                   }, "XF86MonBrightnessDown", function() helper.spawn_program("brightness -dec") end),

    -- DMenu2
    awful.key({ modkey }, "p", function()
        -- TODO: Change to the mouse's screen, instead of the focused client's screen
        scr = awful.screen.focused({client=true})

        local scrgeom = screen[scr].workarea
        awful.util.spawn(string.format("dmenu_custom %s %s %s %s",
            tostring(scrgeom.x), tostring(scrgeom.y),
            tostring(scrgeom.width), tostring(scrgeom.height)
        ))
    end)
)

return key_bindings

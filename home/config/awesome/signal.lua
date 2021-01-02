local awful = require("awful")
local beautiful = require("beautiful")
local helper = require("helper")

local signal = {}

client.connect_signal("focus",   function(c) c.border_color = beautiful.border_focus  end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

client.connect_signal("unmanage", function(c)
    if #c.screen.clients > 0 then
        client.focus = c.screen.clients[1]
    end
end)

screen.connect_signal("removed", function(s)
    -- TODO move those tags to another screen
    -- TODO keep tags sorted
end)

-- When a new client appears
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

-- On screen removed: Tags on the removed screen will be moved to another similar screen,
-- while keeping the same tag focused on that screen
tag.connect_signal("request::screen", function(t)
    for s in screen do
        if s ~= t.screen then
            current_tags = s.selected_tags

            helper.move_tag_to_screen(t, s.index)

            awful.tag.viewnone(s)
            awful.tag.viewmore(current_tags, s)
            helper.force_focus(s)

            return
        end
    end
end)

return signal

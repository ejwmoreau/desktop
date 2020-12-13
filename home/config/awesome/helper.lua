local awful = require("awful")

local helper = {}

function helper.spawn_program(program)
    awful.spawn(program, {
        --tag=screen[awful.screen.focused({client=true})].selected_tag
        tag=mouse.screen.selected_tag
    })
end

function helper.select_next(c)
    -- If there's no other clients to focus on
    if #c.screen.get_clients() == 1 then
        return client.focus
    end

    -- If floating, focus on the 1st index client
    if c.floating then
        awful.client.focus.byidx(1)
        if client.focus then
            client.focus:raise()
        end
        return client.focus
    end

    idx = awful.client.idx(c)

    if idx == nil then
        awful.client.focus.byidx(1)
        if client.focus then
            client.focus:raise()
        end
        return client.focus
    end

    local t = c.screen.selected_tag

    -- Focus on the client right after the current client
    -- If the index of the client is the last index of the column, go up
    if idx["col"] == t.column_count and idx["idx"] == idx["num"] then
        awful.client.focus.byidx(-1)
        if client.focus then
            client.focus:raise()
        end
    else
        awful.client.focus.byidx(1)
        if client.focus then
            client.focus:raise()
        end
    end

    return client.focus
end

function helper.kill_select(c)
    helper.select_next(c)
    c:kill()
end

function helper.move_client_to_screen(c, x, screen_map)
    nextc = helper.select_next(c)
    if x <= #screen_map then
        awful.client.movetoscreen(c, screen_map[x])
    end
    awful.screen.focus(nextc.screen)
end


function helper.focus_on_screen(x, screen_map)
    if x <= #screen_map then
        awful.screen.focus(screen_map[x])
    end
end

function helper.move_tag_to_screen(_tag, _screen_index)
    _tag.selected = false
    _tag.screen = _screen_index
    _tag.selected = true
end

function helper.force_focus(_screen)
    awful.screen.focus(_screen)
    if #_screen.clients > 0 then
        c = _screen.clients[1]
        client.focus = c
        c:raise()
    end
end

function helper.reset_to_primary()
    for k, v in pairs(shared_tag_list) do
        awful.tag.setproperty(v, "hide", true)
        v.screen = 1
        awful.tag.setproperty(v, "hide", false)
    end

    awful.tag.viewnone(screen[1])
    awful.tag.viewmore({shared_tag_list[1]})
end

-- moveresize is relative to the current geometry, there was no alternative...
function helper.client_resize(c, w, h)
    awful.client.moveresize(0, 0, w - c.width, h - c.height, c)
end

-- moveresize is relative to the current geometry, there was no alternative...
function helper.client_move(c, x, y)
    awful.client.moveresize(x - c.x, y - c.y, 0, 0, c)
end

-- moveresize is relative to the current geometry, there was no alternative...
function helper.client_move_on_screen(c, x, y)
    g = awful.screen.focused({client=true}).geometry
    awful.client.moveresize(g.x + (x - c.x), g.y + (y - c.y), 0, 0, c)
end

return helper

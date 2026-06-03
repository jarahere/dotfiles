---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "nautilus"
local menu        = "rofi -show drun"
local browser     = "firefox"


---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Keywords/
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Helper function to make exec binds shorter
local function exec(cmd)
    return hl.dsp.exec_cmd(cmd)
end

-- App launcher
hl.bind(mainMod .. " + Space", exec(menu))
-- Terminal
hl.bind(mainMod .. " + Return", exec(terminal))
-- Browser
hl.bind(mainMod .. " + SHIFT + Return", exec(browser))
-- File manager
hl.bind(mainMod .. " + E", exec(fileManager))
-- Power menu
hl.bind(mainMod .. " + Escape", exec("~/.config/rofi/scripts/power-menu.sh"))
-- Notification center
hl.bind(mainMod .. " + N", exec("swaync-client -t -sw"))
-- Lock system
hl.bind(mainMod .. " + L", exec("hyprlock"))

-- Extra
-- Key bindings
hl.bind(mainMod .. " + K", exec("~/.config/rofi/scripts/key-help.sh"))
-- Screenshot (fullscreen)
hl.bind("Print", exec([[hyprshot -m output -m "$(hyprctl activeworkspace -j | jq -r '.monitor')"]]))
-- Screenshot (region)
hl.bind("SHIFT + Print", exec("pgrep -x slurp > /dev/null || hyprshot -m region"))
-- Clipboard
hl.bind(mainMod .. " + V", exec("~/.config/rofi/scripts/clipboard.sh"))
-- Select wallpaper
hl.bind(mainMod .. " + W", exec("pgrep -x waypaper > /dev/null || waypaper"))

-- System controls
-- System monitor
hl.bind("CTRL + SHIFT + ESCAPE", exec("pgrep -x btop > /dev/null || kitty --class btop-float btop"))
-- Audio controls
hl.bind(mainMod .. " + SHIFT + A", exec("pgrep -x wiremix > /dev/null || kitty --class wiremix-float wiremix"))
-- Bluetooth controls
hl.bind(mainMod .. " + SHIFT + B", exec("pgrep -x bluetui > /dev/null || kitty --class bluetui-float bluetui"))
-- Wifi controls
hl.bind(mainMod .. " + SHIFT + W", exec("pgrep -x impala > /dev/null || kitty --class impala-float sudo impala"))

-- Window
-- Close window
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- Toggle window split
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
-- Toggle window floating/tiling
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))
-- Pseudo window
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo({ action = "toggle" }))
-- Fullscreen
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({
    mode = "fullscreen",
    action = "toggle",
}))
-- Maximize window
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({
    mode = "maximized",
    action = "toggle",
}))

-- Move focus with mainMod + arrow keys
-- Move window focus left
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
-- Move window focus right
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
-- Move window focus up
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
-- Move window focus down
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Swap active window
-- Swap window to the left
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.swap({ direction = "left" }))
-- Swap window to the right
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
-- Swap window up
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.swap({ direction = "up" }))
-- Swap window down
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.swap({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
-- Silently move active window to a workspace with mainMod + CTRL + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0

    -- Switch to workspace
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({
        workspace = i,
    }))

    -- Move window to workspace
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({
        workspace = i,
        follow = true,
    }))

    -- Silently move window to workspace
    hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({
        workspace = i,
        follow = false,
    }))
end

-- Example special workspace (scratchpad)
-- Switch to scratchpad
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- Move window to scratchpad
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({
    workspace = "special:magic",
    follow = true,
}))
-- Silently move window to scratchpad
hl.bind(mainMod .. " + CTRL + S", hl.dsp.window.move({
    workspace = "special:magic",
    follow = false,
}))

-- Troubleshooting
-- Terminate Hyprland session
hl.bind(mainMod .. " + M", exec([[command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()']]))
-- Reload waybar
hl.bind(mainMod .. " + R", exec("killall -9 waybar && waybar &"))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({
    workspace = "e+1",
}))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({
    workspace = "e-1",
}))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), {
    mouse = true,
})
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), {
    mouse = true,
})

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), {
    locked = true,
    repeating = true,
})
hl.bind("XF86AudioLowerVolume", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), {
    locked = true,
    repeating = true,
})
hl.bind("XF86AudioMute", exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), {
    locked = true,
    repeating = true,
})
hl.bind("XF86AudioMicMute", exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), {
    locked = true,
    repeating = true,
})
hl.bind("XF86MonBrightnessUp", exec("brightnessctl set 5%+"), {
    locked = true,
    repeating = true,
})
hl.bind("XF86MonBrightnessDown", exec("brightnessctl set 5%-"), {
    locked = true,
    repeating = true,
})

-- Requires playerctl
hl.bind("XF86AudioNext", exec("playerctl next"), {
    locked = true,
})
hl.bind("XF86AudioPause", exec("playerctl play-pause"), {
    locked = true,
})
hl.bind("XF86AudioPlay", exec("playerctl play-pause"), {
    locked = true,
})
hl.bind("XF86AudioPrev", exec("playerctl previous"), {
    locked = true,
})

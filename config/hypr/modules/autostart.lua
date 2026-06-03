-------------------
---- AUTOSTART ----
-------------------

-- Autostart necessary processes like notifications daemons, status bars, etc.
-- Replaces old `exec-once = ...`

hl.on("hyprland.start", function()
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("waypaper --restore")
  hl.exec_cmd("waybar")
  hl.exec_cmd("swaync")
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("wl-paste --type text --watch cliphist -max-items 20 store")
  hl.exec_cmd("wl-paste --type image --watch cliphist -max-items 20 store")
  hl.exec_cmd("hypridle")
end)

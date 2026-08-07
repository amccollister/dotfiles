--- ENVIRONMENT VARIABLES ---
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("XCURSOR_SIZE",    42)
hl.env("HYPRCURSOR_SIZE", 42)

--- AUTOSTART ---
-- exec on reload
hl.on("config.reloaded", function()
    hl.exec_cmd("pkill waybar; waybar")
end)

-- exec once
hl.on("hyprland.start", function()
    hl.exec_cmd("sunsetr p default")
    hl.exec_cmd("swaync & hypridle")
    hl.exec_cmd("awww-daemon & flameshot")
    hl.exec_cmd("vesktop")
    hl.exec_cmd("[workspace 1 silent] steam")
    hl.exec_cmd("[workspace 1 silent] spotify-launcher")
    hl.exec_cmd("[workspace 3 silent] firefox")
    hl.exec_cmd("obsidian --enable-features=UseOzonePlatform --ozone-platform=wayland")
    
    -- store clipboard history
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)


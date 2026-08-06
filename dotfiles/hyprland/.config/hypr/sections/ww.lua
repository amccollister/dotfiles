--- WINDOWS AND WORKSPACES ---

-- Assign programs to specific workspaces
hl.window_rule({ match = { class = "steam", },    workspace = 1, no_initial_focus = true, float = false })
hl.window_rule({ match = { class = "spotify", },  workspace = 1, no_initial_focus = true})
hl.window_rule({ match = { class = "vesktop", },  workspace = 5, no_initial_focus = true})
hl.window_rule({ match = { class = "obsidian", }, workspace = 6, no_initial_focus = true})

-- Kitty Special Workspace Rules
hl.workspace_rule({ workspace = "special:kitty_drop", on_created_empty = "[float] kitty --session ~/.config/kitty/drop.kitty-session" })
hl.window_rule({ match = { workspace = "special:kitty_drop", class = "kitty" }, move = { "monitor_w * 0.005", "monitor_h * 0.01" }, size = { "monitor_w * 0.99", "monitor_h * 0.5" } })

-- Stopped working for the actual kitty program
-- hl.window_rule({ match = { workspace = "special:kitty_drop", }, workspace = "+0", }) -- don't open programs in the special workspace

-- Flameshot Special Window Rules
hl.window_rule({ match = { class = "flameshot", title = "flameshot" }, decorate = false, no_anim = true, float = true, pin = true,})

-- Add blur to specific windows -- ignorealpha doesn't blur is alpha is under value
hl.layer_rule({match = {namespace = "match:namespace rofi"                       },    blur = true         })
hl.layer_rule({match = {namespace = "match:namespace rofi"                       },    ignore_alpha = 0.5  })
hl.layer_rule({match = {namespace = "match:namespace swaync-control-center"      },    blur = true         })
hl.layer_rule({match = {namespace = "match:namespace swaync-control-center"      },    ignore_alpha = 0.25 })
hl.layer_rule({match = {namespace = "match:namespace swaync-notification-window" },    blur = true         })
hl.layer_rule({match = {namespace = "match:namespace swaync-notification-window" },    ignore_alpha = 0.25 })

-- Ignore maximize requests from all apps. You'll probably like this.
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- Fix some dragging issues with XWayland
hl.window_rule({ match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false, }, no_focus = true })

--- APPEARANCE ---
hl.config({
    general = {
        border_size         = 2,
        gaps_in             = 4,
        gaps_out            = 8,
        col = {
            active_border   = color12,
            inactive_border = color0,
        },
    },
    decoration = {
        rounding            = 10,
        rounding_power      = 2,
        active_opacity      = 0.97,  -- Opacity just seems so...
        inactive_opacity    = 0.85,  -- extra
        --active_opacity      = 1.00,
        --inactive_opacity    = 1.00, 

        blur    = { enabled = true, popups = true, special = true, size = 3, passes = 3 },
        shadow  = { enabled = true, range = 15, render_power = 5, color = color0 },
    },
    -- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
    animations  = { workspace_wraparound = true },
    dwindle     = { preserve_split = true },
    misc        = { disable_hyprland_logo = true }
})

hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1.00} }})
hl.curve("almostLinear",   { type = "bezier", points = { {0.50, 0.50}, {0.75, 1.00} }})
hl.curve("fluid",          { type = "bezier", points = { {0.15, 0.85}, {0.25, 1.00} }})
hl.curve("snappy",         { type = "bezier", points = { {0.30, 1.00}, {0.40, 1.00} }})

hl.animation({ leaf = "border",     enabled = true, speed = 5, bezier = "fluid"                               })
hl.animation({ leaf = "windows",    enabled = true, speed = 4, bezier = "fluid",          style = "popin 25%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "snappy",         style = "popin 25%" })
hl.animation({ leaf = "layers",     enabled = true, speed = 2, bezier = "easeInOutCubic", style = "fade"      })
hl.animation({ leaf = "fade",       enabled = true, speed = 4, bezier = "snappy"                              })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "easeInOutCubic", style = "slide"     })

-- Kitty Animation
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3.5, bezier = "almostLinear", style = "slidevert -75%" })

--- DISPLAY ---

--360HZ not applying automatically... why?
hl.monitor({output = "DP-1", mode = "2560x1440@360.00Hz", position = "2560x0", scale = 1})
hl.monitor({output = "DP-2", mode = "2560x1440@180.00Hz", position = "5120x0", scale = 1})
hl.monitor({output = "DP-3", mode = "2560x1440@180.00Hz", position = "0x0",    scale = 1})

-- Assigning workspaces to specific monitors
hl.workspace_rule({ workspace = 1, monitor = "DP-3"})
hl.workspace_rule({ workspace = 2, monitor = "DP-3"})
hl.workspace_rule({ workspace = 3, monitor = "DP-1"})
hl.workspace_rule({ workspace = 4, monitor = "DP-1"})
hl.workspace_rule({ workspace = 5, monitor = "DP-2"})
hl.workspace_rule({ workspace = 6, monitor = "DP-2"})

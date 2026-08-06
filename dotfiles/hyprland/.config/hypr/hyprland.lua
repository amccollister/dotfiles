require("~/.cache/wal/colors-hyprland.lua")

-- Change display based on monitor size
local resolution = 0
for _, mon in ipairs(hl.get_monitors()) do
    resolution = math.max(resolution, mon.height)
end

if resolution == 1440 then
    require("sections/display_1440")
elseif resolution == 1080 then
    require("sections/display_1080")
end

require("sections/env")
require("sections/appearance")
require("sections/controls")
require("sections/ww")

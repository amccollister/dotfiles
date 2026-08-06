--- INPUT ---
hl.config({
    input = {
        kb_layout                   = "us",
        follow_mouse                = 2,    -- Focus only changes on a mouse click
        float_switch_override_focus = 0,
        special_fallthrough         = true, -- Interesting interaction with the blur
        sensitivity                 = -1,   -- -1.0 - 1.0, 0 means no modification.
        touchpad = {
            natural_scroll          = true,
        },
    },
})

--- KEYBINDS ---
local mainMod = "SUPER" -- Sets "Windows" key as main modifier
local terminal = "kitty"
local file_manager = "thunar"
local launcher = "~/.config/rofi/menus/launcher.sh"
local switcher = "~/.config/rofi/menus/switcher.sh"
local cliphist = "~/.config/rofi/menus/cliphist.sh"
local imghist = "~/.config/rofi/menus/imghist.sh"

-- DIY dropdown terminal -- See window/workspace rules for more info
hl.bind(mainMod .. " + Escape", hl.dsp.workspace.toggle_special("kitty_drop"))

-- Primary keybinds -- see https://wiki.hypr.land/Configuring/Binds
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind("ALT" .. " + Tab", hl.dsp.exec_cmd(switcher))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(cliphist))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(launcher))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(file_manager))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + V", hl.dsp.layout("togglesplit")) -- dwindle?
hl.bind(mainMod .. " + G", hl.dsp.window.pseudo())       -- dwindle?

-- SHIFT keybinds
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(imghist))
hl.bind(mainMod .. " + SHIFT + S", function()
    local mon = hl.get_active_monitor()
    local n = mon and mon.id or 0
    hl.exec_cmd("flameshot screen --number " .. n .. " --edit -c")
end)

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize({ keep_aspect_ratio = false }), { mouse = true })
hl.bind(mainMod .. " + SHIFT + mouse:273", hl.dsp.window.resize({ keep_aspect_ratio = true }), { mouse = true})

-- Assign workspaces to number keys
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Use SUPER + LEFT/RIGHT to switch workspaces instead of window focus
-- (was: "Focus on left window" / "Focus on right window")
-- "r-1"/"r+1" cycles workspaces on the current monitor only, unlike "e-1"/"e+1"
-- which jumps to the next existing workspace across ALL monitors.
hl.unbind("SUPER + LEFT")
hl.unbind("SUPER + RIGHT")
o.bind("SUPER + LEFT", "Previous workspace", hl.dsp.focus({ workspace = "r-1" }))
o.bind("SUPER + RIGHT", "Next workspace", hl.dsp.focus({ workspace = "r+1" }))

-- Disable monitor scaling shortcuts (was: "Monitor scaling up" / "Monitor scaling down")
hl.unbind("SUPER + SLASH")
hl.unbind("SUPER + ALT + SLASH")

-- Move "Capture menu" from SUPER + CTRL + C to SUPER + SHIFT + S
-- (was: SUPER + CTRL + C = "Capture menu", SUPER + SHIFT + S = "Google Maps")
hl.unbind("SUPER + CTRL + C")
hl.unbind("SUPER + SHIFT + S")
o.bind("SUPER + SHIFT + S", "Capture menu", "omarchy-menu capture")

-- Maximize window on SUPER + D (in addition to the SUPER + ALT + F default)
o.bind("SUPER + D", "Maximize", hl.dsp.window.fullscreen({ mode = "maximized" }))

-- Move "File manager" from SUPER + SHIFT + F to SUPER + E
-- (was: SUPER + SHIFT + F = "File manager")
hl.unbind("SUPER + SHIFT + F")
o.bind("SUPER + E", "File manager", { omarchy = "nautilus" })

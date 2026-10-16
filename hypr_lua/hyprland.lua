-- -----------------------------------------------------
--  _   _                  _                 _
-- | | | |_   _ _ __  _ __| | __ _ _ __  __| |
-- | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` |
-- |  _  | |_| | |_) | |  | | (_| | | | | (_| |
-- |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|
--        |___/|_|
-- -----------------------------------------------------
-- Hyprland Native Lua Configuration
-- Entry point replacing legacy hyprland.conf

-- -----------------------------------------------------
-- Environment & System Setup
-- -----------------------------------------------------
require("conf.environment")

-- -----------------------------------------------------
-- Color Palette / Pywal Cache
-- -----------------------------------------------------
-- Loads generated Pywal color variables
pcall(require, "colors-hyprland")

-- -----------------------------------------------------
-- Display & Autostart
-- -----------------------------------------------------
require("conf.monitor")
require("conf.autostart")
require("conf.cursor")
require("conf.keyboard")

-- -----------------------------------------------------
-- Core UI & Window Configurations
-- -----------------------------------------------------
require("conf.window")
require("conf.decoration")
require("conf.layout")
require("conf.misc")
require("conf.keybinding")
require("conf.windowrule")

-- -----------------------------------------------------
-- Animation & Custom Variations
-- -----------------------------------------------------
require("conf.animation")
require("conf.custom")

-- -----------------------------------------------------
-- Portal Initialization
-- -----------------------------------------------------
hl.exec("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

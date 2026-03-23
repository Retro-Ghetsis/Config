#!/usr/bin/env fish

set DIR ~/.config/Theming/Colors
set ROFI_THEME ~/.config/rofi/

set modes Waybar Colorscheme Wallpaper
set selection (printf "%s\n" $modes | rofi -dmenu -p "Config" -theme $ROFI_THEME/style-1.rasi)
test -z "$selection"; and exit

# --- Functions ---
function restart_waybar
    pkill waybar
    waybar &
end

function restart_dock
    pkill nwg-dock-hyprland
    nwg-dock-hyprland -d &
end

function restart_osd
    pkill swayosd-server
    swayosd-server &
end

# --- Main Switch ---
switch $selection

case Waybar
    set configs (for d in ~/.config/waybar/custom/*; basename $d; end)
    set config (printf "%s\n" $configs | rofi -dmenu -p "Waybar" -theme $ROFI_THEME/style-1.rasi)
    test -z "$config"; and exit

    cp ~/.config/waybar/custom/$config/config.jsonc ~/.config/waybar/
    cp ~/.config/waybar/custom/$config/style.css ~/.config/waybar/
    restart_waybar

case Colorscheme
    set colors (for d in $DIR/*; basename $d; end)
    set color (printf "%s\n" $colors | rofi -dmenu -p "Colors" -theme $ROFI_THEME/style-1.rasi)
    test -z "$color"; and exit

    # Copy config files
    cp $DIR/$color/kitty/colors.conf ~/.config/kitty/
    cp $DIR/$color/waybar/colors.css ~/.config/waybar/
    cp $DIR/$color/rofi/color.rasi ~/.config/rofi/colors
    cp $DIR/$color/waybar/colors.css ~/.config/nwg-dock-hyprland

    # GTK theme
    gsettings set org.gnome.desktop.interface gtk-theme "$color-Dark"

    # Refresh apps
    nautilus -q
    pkill -USR1 kitty
    restart_dock
    restart_osd

    # Save current theme
    echo $color > ~/.config/Theming/current_theme

    # Apply default wallpaper (pick first background*)
    set wall (for f in $DIR/$color/wallpapers/background*; echo $f; break; end)
    swww img $wall --transition-duration 1.5 --transition-type any
    sudo cp $wall /usr/share/sddm/themes/pixie/assets/

    restart_waybar
    echo "done"

case Wallpaper
    set theme (cat ~/.config/Theming/current_theme)

    # Gather wallpapers
    set wallpapers (for w in $DIR/$theme/wallpapers/*; basename $w; end)

    # Build Rofi entries (icon only)
    set entries
    for w in $DIR/$theme/wallpapers/*
        set entries $entries "\x00icon\x1f$w"
    end

    # Show Rofi; get selected index
    set idx (printf "%b\n" $entries | rofi -dmenu -show-icons -format i -p "Wallpaper" -theme $ROFI_THEME/wallpaper.rasi)
    test -z "$idx"; and exit

    # Convert index to filename
    set wallfile $wallpapers[(math $idx + 1)]
    set wallpath $DIR/$theme/wallpapers/$wallfile

    # Apply wallpaper
    swww img $wallpath --transition-duration 1.5 --transition-type any
    cp $wallpath ~/.config/Theming/background.jpg
end

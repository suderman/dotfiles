# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

# Produces "21 days", for example
uptime_formatted=$(uptime | cut -d ',' -f1  | cut -d ' ' -f4,5)

# The abbreviated weekday (e.g., "Sat"), followed by the ISO-formatted date
# like 2018-10-06 and the time (e.g., 14:01)
date_formatted=$(date "+ %b %d, %l:%M %P")

# Get the Linux version but remove the "-1-ARCH" part
linux_version=$(uname -r | cut -d '-' -f1)

airplane_mode="✈️"
[ -z "$(rfkill | grep ' blocked')" ] && airplane_mode=""

mute_icon="🔇"
[ -z "$(pactl get-sink-mute @DEFAULT_SINK@ | grep yes)" ] && mute_icon=""

# Returns the battery status: "Full", "Discharging", or "Charging".
battery_percent=$(cat /sys/class/power_supply/BAT1/capacity)%
battery_status=$(cat /sys/class/power_supply/BAT1/status)
battery_icon="🔌"
[ "$battery_status" = "Charging" ] && battery_icon="⚡"
[ "$battery_status" = "Discharging" ] && battery_icon="🔋" 

# Emojis and characters for the status bar
# 💎 💻 💡 🔌 ⚡ 📁 \|
echo $airplane_mode $mute_icon $uptime_formatted ↑ $linux_version 🐧 $battery_percent $battery_icon $date_formatted

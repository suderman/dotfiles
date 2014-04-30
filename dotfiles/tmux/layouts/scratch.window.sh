# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
#window_root "~/Projects/scratch"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "scratch"

# Split window into panes.
split_v 20
split_h 50

# Run commands.
run_cmd "top" 1    # runs in active pane
run_cmd "date" 2  # runs in pane 1

# Paste text
# send_keys "top"    # paste into active pane
# send_keys "date" 1 # paste into active pane

# Set active pane.
select_pane 1

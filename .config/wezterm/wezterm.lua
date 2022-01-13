local wezterm = require 'wezterm';
return {

  font = wezterm.font("JetBrains Mono"),
  -- font = wezterm.font("Noto Color Emoji"),
  -- font = wezterm.font("PowerlineExtraSymbols"), =>
  color_scheme = "Batman",

  enable_wayland = true,

  window_decorations = "RESIZE",

  use_fancy_tab_bar = false,

  window_padding = {
    left = "0.5cell",
    right = "0.5cell",
    top = "0.1cell",
    bottom = "0.1cell",
  },

  keys = {

    -- {key="c", mods="SUPER", action='CopyTo="Clipboard"'},
    -- {key="v", mods="SUPER", action='PasteFrom="Clipboard"'},
    -- {key="]", mods="SUPER", action='ActivateTabRelative=1"'},
    -- {key="[", mods="SUPER", action='ActivateTabRelative=-1"'},

    -- {key="c", mods="CTRL", action=wezterm.action{CopyTo="Clipboard"}},
    {key="v", mods="CTRL", action=wezterm.action{PasteFrom="Clipboard"}},

    -- {key="c", mods="SUPER", action=wezterm.action{CopyTo="Clipboard"}},
    -- {key="v", mods="SUPER", action=wezterm.action{PasteFrom="Clipboard"}},

    {key="[", mods="SUPER", action=wezterm.action{ActivateTabRelative=-1}},
    {key="]", mods="SUPER", action=wezterm.action{ActivateTabRelative=1}},

    -- Turn off the default CMD-m Hide action
    {key="m", mods="SUPER", action="DisableDefaultAssignment"}

  },

  launch_menu = {
    {
      args = {"btop"},
    },
    {
      -- Optional label to show in the launcher. If omitted, a label
      -- is derived from the `args`
      label = "Bash",
      -- The argument array to spawn.  If omitted the default program
      -- will be used as described in the documentation above
      args = {"bash", "-l"},

      -- You can specify an alternative current working directory;
      -- if you don't specify one then a default based on the OSC 7
      -- escape sequence will be used (see the Shell Integration
      -- docs), falling back to the home directory.
      -- cwd = "/some/path"

      -- You can override environment variables just for this command
      -- by setting this here.  It has the same semantics as the main
      -- set_environment_variables configuration option described above
      -- set_environment_variables = { FOO = "bar" },
    },
  }
}

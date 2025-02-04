export def --env light [] {
  catppuccin-latte set color_config
  $env.THEME = "light"
}

export def --env dark [] {
  catppuccin-macchiato set color_config
  $env.THEME = "dark"
}


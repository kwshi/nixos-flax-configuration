css: let
  blockPadding = "4px 12px";
in [
  (css "*" {
    font-family = "'JuliaMono', 'FontAwesome 6 Free'";
    font-size = "14px";
  })

  (css "window#waybar" {
    background-color = "transparent";
    color = " #ebdbb2";
  })

  (css [
    "#clock"
    "#battery"
    "#pulseaudio"
    "#backlight"
    "#network"
  ] {padding = blockPadding;})

  (css "#clock" {background-color = "#076678";})
  (css "#battery" {background-color = "#9d0006";})
  (css "#pulseaudio" {background-color = "#af3a03";})
  (css "#backlight" {background-color = "#b57614";})
  (css "#network" {background-color = "#79740e";})

  (css "#tags button" {
      background-color = "#32302f";
      border-radius = "0";
      border = "none";
      box-shadow = "none";
      transition = "none";
      font-weight = "bold";
      min-width = "0";
      padding = blockPadding;
      color = "#fbf1c7";
    }
    [
      (css "&.occupied:not(.focused)" {
        background-color = "#8f3f71";
      })
      (css "&.focused" {
        background-color = "#d3869b";
        color = "#1d2021";
      })
      (css "&.urgent" {
        background-color = "#fb4934";
      })
      (css "&:hover" {
        outline = "none";
        box-shadow = "none";
        text-shadow = "none";
        background-image = "none";
      })
    ])
]

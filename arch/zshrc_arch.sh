#Help function to see if a command exists
command_exists () {
  type "$1" >/dev/null 2>/dev/null
}

if command_exists feh ; then
    #feh --bg-scale ~/other/backgrounds/abstract-mosaic-background.png
    feh --bg-scale ~/other/backgrounds/wallhaven-375988_spaceship.jpg
fi

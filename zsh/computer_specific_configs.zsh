# Disable touchpad on thinkpad computers
if [ -f ~/.identifiers/thinkpad ]; then
    if [ ! -f /tmp/xinput_is_set ]; then
        touch /tmp/xinput_is_set
        #Disable TouchPad:
        declare -i ID
        ID=`xinput list | grep -Eo 'TouchPad\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'`
        xinput set-prop $ID "Device Enabled" 0
        #echo 'Touchpad has been disabled.'
        
        #Increase speed of trackpoint. Default is 1.0, 0.9 is faster
        TRACKPOINT_NAME=$(xinput --list --name-only | g -i trackpoint)
        xinput --set-prop "$TRACKPOINT_NAME" "Device Accel Constant Deceleration" 0.9
    fi
    
    # Set the bg, but only if it hasn't been set before
    if [ ! -f /tmp/bg_is_set ]; then
        touch /tmp/bg_is_set
        if [ -f ~/.identifiers/orexplore ]; then
            feh --bg-scale \
                /usr/share/wallpapers/Next/contents/images/2560x1600.png \
                &> /dev/null
            # ~/.screenlayout/T460s_and_1920x1200.sh
        else
            feh --bg-scale \
                ~/other/backgrounds/beautiful_landscape.jpg \
                &> /dev/null
        fi
    fi
fi

if [ -f ~/.identifiers/ran-ub1610-vb ]; then
    if [ -n "$DISPLAY" ]; then
        #set background image:
        feh --bg-scale ~/other/backgrounds/house_on_water_1920_1080.jpg    
    fi
    
    #Change tmux bgcolor without changing tmux.conf:
    tmux set -g status-bg '#343d46'
 
    # oh-my-zsh right prompt
    export RPROMPT=$(hostname)
fi

if [ -f ~/.identifiers/ran-ub ]; then
    if [ -n "$DISPLAY" ]; then
        #set background image:
        # feh --bg-scale ~/other/backgrounds/lake_and_ocean_bg.jpg
        feh --bg-scale /home/ran/Downloads/wallpaper/alena-aenami-atlast2k2.jpg
    fi
    
    if command_exists gsettings && [ ! -f /tmp/suspend_on_ac_is_disabled ]; then
        touch /tmp/suspend_on_ac_is_disabled
        gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
    fi
fi

#Mac-specific stuff
if [[ "$OSTYPE" =~ ^darwin ]]; then
    source ~/dotfiles/mac/zshrc_mac.sh
fi

if [ -f "/etc/arch-release" ]; then
    source ~/dotfiles/arch/zshrc_arch.sh
fi

if [ -f "$HOME/dotfiles/private/zsh/computer_specific_configs.zsh" ]; then
    source ~/dotfiles/private/zsh/computer_specific_configs.zsh
fi

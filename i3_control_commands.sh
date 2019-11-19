#!/bin/bash

run_on_startup ()
{
    # Add all of the monitor sizes we might need
    # 1800x1200 (Set it here)
    gtf 1800 1200 60
    xrandr --newmode "1800x1200_60.00"  180.64  1800 1920 2112 2424  1200 1201 1204 1242  -HSync +Vsync
    xrandr --addmode eDP-1 "1800x1200_60.00"
    xrandr --output eDP-1 --mode "1800x1200_60.00"

    # 1920x1280
    gtf 1920 1280 60
    xrandr --newmode "1920x1280_60.00"  207.34  1920 2056 2264 2608  1280 1281 1284 1325  -HSync +Vsync
    xrandr --addmode eDP-1 "1920x1280_60.00"

    # Set our keyboard repeat rate to be much higher than the stock rate
    xset r rate 200 40
}


# increase screen brightness
inc_brightness() 
{
    BRIGHTNESS=`xrandr --verbose | grep -m 1 -i brightness | cut -f2 -d ' '`
    NEW_BRIGHT=$(bc <<< "$BRIGHTNESS + 0.1")
    if [[ $(bc <<< "1.0 <= $NEW_BRIGHT") -eq 1 ]]; then  # We have reached max brightness; don't go farther
        xrandr --output eDP-1 --brightness 1.0
        echo 1.0 > /home/brandon/.config/brightness
    elif [[ $(bc <<< "0.0 >= $NEW_BRIGHT") -eq 1 ]]; then  # We have reached min brightness; don't go farther
        xrandr --output eDP-1 --brightness 0.0
        echo 0.0 > /home/brandon/.config/brightness
    else
        xrandr --output eDP-1 --brightness $NEW_BRIGHT
        echo $NEW_BRIGHT > /home/brandon/.config/brightness
    fi
}

dec_brightness ()
{
    BRIGHTNESS=`xrandr --verbose | grep -m 1 -i brightness | cut -f2 -d ' '`
    NEW_BRIGHT=$(bc <<< "$BRIGHTNESS - 0.1")
    if [[ $(bc <<< "1.0 <= $NEW_BRIGHT") -eq 1 ]]; then  # We have reached max brightness; don't go farther
        xrandr --output eDP-1 --brightness 1.0
        echo 1.0 > /home/brandon/.config/brightness
    elif [[ $(bc <<< "0.0 >= $NEW_BRIGHT") -eq 1 ]]; then  # We have reached min brightness; don't go farther
        xrandr --output eDP-1 --brightness 0.0
        echo 0.0 > /home/brandon/.config/brightness
    else
        xrandr --output eDP-1 --brightness $NEW_BRIGHT
        echo $NEW_BRIGHT > /home/brandon/.config/brightness
    fi
}

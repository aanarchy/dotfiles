#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Mail : adi1090x@gmail.com
## browser : @adi1090x
## music : @adi1090x

config=$HOME/.config/rofi/user.conf

if test -f "$config"; then
    . $config
    rofi_command="rofi -theme android/six.rasi"
    
    # Links
    terminal=""
    files=""
    editor=""
    browser=""
    whatsapp="甆"
    discord=""
    mail=""
    tweetdeck=""
    
    # Variable passed to rofi
    options="$terminal\n$files\n$editor\n$browser\n$whatsapp\n$discord\n$mail\n$tweetdeck"
    
    chosen="$(echo -e "$options" | $rofi_command -p "Most Used" -dmenu -selected-row 0)"
    case $chosen in
        $terminal)
            ${TERMINAL} &
            ;;
        $files)
            ${user[file_manager]} &
            ;;
        $editor)
            ${user[editor]} &
            ;;
        $browser)
            ${BROWSER} &
            ;;
        $whatsapp)
            bsptool -r web.whatsapp.com "chromium --app=https://web.whatsapp.com --new-window" true &
            ;;
        $discord)
            bsptool -r discord discord true &
            ;;
        $mail)
            ${user[email_client]} &
            ;;
        $tweetdeck)
            bsptool -r tweetdeck.twitter.com 'chromium --app=https://tweetdeck.twitter.com --new-window' true &
            ;;
    esac
fi

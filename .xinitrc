#!/bin/bash
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
[ -f "$HOME/.xprofile" ] && . ~/.xprofile

eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
export $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
dbus-update-activation-environment --systemd DISPLAY

exec bspwm


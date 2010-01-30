xsetroot -solid "#303030"

if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval `dbus-launch --sh-syntax --exit-with-session`
fi

xrdb -load ~/.Xdefaults

# gnome-settings-daemon &

# Preload stuff for KDE apps
if which start_kdeinit >/dev/null; then
 LD_BIND_NOW=true start_kdeinit --new-startup +kcminit_startup &
fi

# Others 
eval `cat /home/daniel/.fehbg` &
sleep 1s && tint2 &
# xcompmgr -c -t-5 -l-5 -r4.7 -o.65 &
knetworkmanager & 
kmix --keepvisibility &
klipper &

syndaemon -i 2 -d -t -K
$HOME/bin/middle-click

sleep 5s && urxvt &


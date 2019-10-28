#!/system/bin/sh
#Preinstall app by Le Hoang

if [ ! -e /data/system.notfirstrun ]; then	
    echo "do preinstall job"
    for app in /vendor/preinstall/*.apk; do pm install -r $app; done
    touch /data/system.notfirstrun
    echo "preinstall ok"
fi

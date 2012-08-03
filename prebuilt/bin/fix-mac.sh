#!/system/bin/sh

PATH=/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin
ORIG_NVS_BIN=/system/etc/firmware/ti-connectivity/wl1271-nvs_127x.bin
NVS_BIN=/system/etc/firmware/ti-connectivity/wl1271-nvs.bin

if [ ! -f "$NVS_BIN" ]; then
    busybox mount -o remount,rw /system
    cp ${ORIG_NVS_BIN} ${NVS_BIN}
    calibrator set nvs_mac $NVS_BIN $(idme ?|grep 0x0030 |cut -c35-46|sed -e 's/)//g'|sed -e 's/-//g'|sed 's/../&:/g;s/:$//')
    busybox mount -o remount,ro /system
fi


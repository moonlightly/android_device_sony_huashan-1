#!/sbin/busybox sh
set +x
_PATH="$PATH"
export PATH=/sbin

LED_RED="/sys/class/leds/LED1_R/brightness"
LED_RED_CURRENT="/sys/class/leds/LED1_R/led_current"
LED2_RED="/sys/class/leds/LED2_R/brightness"
LED2_RED_CURRENT="/sys/class/leds/LED2_R/led_current"
LED3_RED="/sys/class/leds/LED3_R/brightness"
LED3_RED_CURRENT="/sys/class/leds/LED3_R/led_current"

busybox cd /
busybox date >>boot.txt
exec >>boot.txt 2>&1
busybox rm /init

# include device specific vars
source /sbin/bootrec-device

# create directories
busybox mkdir -m 755 -p /dev/block
busybox mkdir -m 755 -p /dev/input
busybox mkdir -m 555 -p /proc
busybox mkdir -m 755 -p /sys

# create device nodes
busybox mknod -m 600 /dev/block/mmcblk0 b 179 0
busybox mknod -m 600 ${BOOTREC_EVENT_NODE}
busybox mknod -m 666 /dev/null c 1 3

# mount filesystems
busybox mount -t proc proc /proc
busybox mount -t sysfs sysfs /sys

echo '96' > $LED_RED
echo '96' > $LED_RED_CURRENT
echo '96' > $LED3_RED
echo '96' > $LED3_RED_CURRENT
echo '96' > $LED2_RED
echo '96' > $LED2_RED_CURRENT

# keycheck
busybox cat ${BOOTREC_EVENT} > /dev/keycheck&
busybox sleep 3

# android ramdisk
load_image=/sbin/ramdisk.cpio

# boot decision
if [ -s /dev/keycheck ] || busybox grep -q warmboot=0x77665502 /proc/cmdline ; then
	busybox echo 'RECOVERY BOOT' >>boot.txt
	# recovery ramdisk
	busybox echo '100' > /sys/class/timed_output/vibrator/enable
	echo '96' > $LED_RED
	echo '96' > $LED_RED_CURRENT
	echo '96' > $LED3_RED
	echo '96' > $LED3_RED_CURRENT
	echo '96' > $LED2_RED
	echo '96' > $LED2_RED_CURRENT
	busybox mknod -m 600 ${BOOTREC_FOTA_NODE}
	busybox mount -o remount,rw /
	busybox ln -sf /sbin/busybox /sbin/sh
	extract_elf_ramdisk -i ${BOOTREC_FOTA} -o /sbin/ramdisk-recovery.cpio -t / -c
	busybox rm /sbin/sh
	load_image=/sbin/ramdisk-recovery.cpio
else
	busybox echo 'ANDROID BOOT' >>boot.txt
	# poweroff LED
	echo '96' > $LED_RED
	echo '96' > $LED_RED_CURRENT
	echo '96' > $LED3_RED
	echo '96' > $LED3_RED_CURRENT
	echo '96' > $LED2_RED
	echo '96' > $LED2_RED_CURRENT
fi

# kill the keycheck process
busybox pkill -f "busybox cat ${BOOTREC_EVENT}"
busybox echo '0' > /sys/class/timed_output/vibrator/enable
echo '96' > $LED_RED
echo '96' > $LED_RED_CURRENT
echo '96' > $LED3_RED
echo '96' > $LED3_RED_CURRENT
echo '96' > $LED2_RED
echo '96' > $LED2_RED_CURRENT

busybox umount /proc
busybox umount /sys

busybox rm -fr /dev/*
busybox date >>boot.txt

busybox cpio -ui < ${load_image}

export PATH="${_PATH}"
exec /init

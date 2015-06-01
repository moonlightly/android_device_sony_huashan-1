#!/sbin/busybox sh
set +x
_PATH="$PATH"
export PATH=/sbin

# leds paths
RED1_LED_FILE="/sys/class/leds/LED1_R/brightness"
RED2_LED_FILE="/sys/class/leds/LED2_R/brightness"
RED3_LED_FILE="/sys/class/leds/LED3_R/brightness"
RED1C_LED_FILE="/sys/class/leds/LED1_R/led_current"
RED2C_LED_FILE="/sys/class/leds/LED2_R/led_current"
RED3C_LED_FILE="/sys/class/leds/LED3_R/led_current"
GREEN1_LED_FILE="/sys/class/leds/LED1_G/brightness"
GREEN2_LED_FILE="/sys/class/leds/LED2_G/brightness"
GREEN3_LED_FILE="/sys/class/leds/LED3_G/brightness"
GREEN1C_LED_FILE="/sys/class/leds/LED1_G/led_current"
GREEN2C_LED_FILE="/sys/class/leds/LED2_G/led_current"
GREEN3C_LED_FILE="/sys/class/leds/LED3_G/led_current"
BLUE1_LED_FILE="/sys/class/leds/LED1_B/brightness"
BLUE2_LED_FILE="/sys/class/leds/LED2_B/brightness"
BLUE3_LED_FILE="/sys/class/leds/LED3_B/brightness"
BLUE1C_LED_FILE="/sys/class/leds/LED1_B/led_current"
BLUE2C_LED_FILE="/sys/class/leds/LED2_B/led_current"
BLUE3C_LED_FILE="/sys/class/leds/LED3_B/led_current"

# boot init
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

# boot lights off
echo '0' > $RED1_LED_FILE
echo '0' > $RED1C_LED_FILE

# keycheck
busybox echo '50' > /sys/class/timed_output/vibrator/enable
busybox cat ${BOOTREC_EVENT} > /dev/keycheck&

# lights wave animation
echo '128' > $GREEN1_LED_FILE
echo '128' > $GREEN1C_LED_FILE
busybox sleep 0.5
echo '128' > $RED3_LED_FILE
echo '128' > $RED3C_LED_FILE
echo '128' > $BLUE2_LED_FILE
echo '128' > $BLUE2C_LED_FILE
busybox sleep 2

# lights off
echo '0' > $GREEN1_LED_FILE
echo '0' > $GREEN1C_LED_FILE
echo '0' > $BLUE2_LED_FILE
echo '0' > $BLUE2C_LED_FILE
echo '0' > $RED3_LED_FILE
echo '0' > $RED3C_LED_FILE

# android ramdisk
load_image=/sbin/ramdisk.cpio

# boot decision
if [ -s /dev/keycheck ] || busybox grep -q warmboot=0x77665502 /proc/cmdline ; then
	busybox echo 'RECOVERY BOOT' >>boot.txt
	# recovery ramdisk
	busybox echo '100' > /sys/class/timed_output/vibrator/enable
	echo '128' > $BLUE1_LED_FILE
	echo '128' > $BLUE1C_LED_FILE
	echo '128' > $BLUE2_LED_FILE
	echo '128' > $BLUE2C_LED_FILE
	echo '128' > $BLUE3_LED_FILE
	echo '128' > $BLUE3C_LED_FILE
	busybox sleep 1
	busybox mknod -m 600 ${BOOTREC_FOTA_NODE}
	busybox mount -o remount,rw /
	busybox ln -sf /sbin/busybox /sbin/sh
	extract_elf_ramdisk -i ${BOOTREC_FOTA} -o /sbin/ramdisk-recovery.cpio -t / -c
	busybox rm /sbin/sh
	load_image=/sbin/ramdisk-recovery.cpio
else
	busybox echo 'ANDROID BOOT' >>boot.txt
	echo '128' > $GREEN1_LED_FILE
	echo '128' > $GREEN1C_LED_FILE
	echo '128' > $GREEN2_LED_FILE
	echo '128' > $GREEN2C_LED_FILE
	echo '128' > $GREEN3_LED_FILE
	echo '128' > $GREEN3C_LED_FILE
fi

# kill the keycheck process
busybox pkill -f "busybox cat ${BOOTREC_EVENT}"
busybox echo '0' > /sys/class/timed_output/vibrator/enable

# lights off
busybox sleep 1
echo '0' > $RED1_LED_FILE
echo '0' > $RED1C_LED_FILE
echo '0' > $RED2_LED_FILE
echo '0' > $RED2C_LED_FILE
echo '0' > $RED3_LED_FILE
echo '0' > $RED3C_LED_FILE
echo '0' > $GREEN1_LED_FILE
echo '0' > $GREEN1C_LED_FILE
echo '0' > $GREEN2_LED_FILE
echo '0' > $GREEN2C_LED_FILE
echo '0' > $GREEN3_LED_FILE
echo '0' > $GREEN3C_LED_FILE

# final unmount
busybox umount /proc
busybox umount /sys
busybox rm -fr /dev/*
busybox date >>boot.txt

# image loaded
busybox cpio -ui < ${load_image}
export PATH="${_PATH}"
exec /init

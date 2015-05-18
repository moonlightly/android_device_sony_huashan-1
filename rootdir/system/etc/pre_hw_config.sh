# LMU AS3677 Configuration before chargemon
dev=/sys/bus/i2c/devices/10-0040/lcd-backlight_1/device/
echo 0 > $dev/als_on  #Sensor on/off. 1 = on, reg 90h
echo 0x07=0x0e > $dev/debug
echo 1 > /sys/bus/i2c/devices/10-0040/lcd-backlight_1/use_dls
echo 1 > /sys/bus/i2c/devices/10-0040/lcd-backlight_2/use_dls
echo 0x2c=0x80 > $dev/debug #2ch : 0x80 (step_up_fb_pwm on) : gpio current
echo 1 > $dev/als_gain #meaning gain=1/2  90h[2:1] : 0b10 (1)

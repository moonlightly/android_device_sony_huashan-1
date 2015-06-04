/*
 * Copyright (C) 2012-2013 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* ===================================================================== */
/* === LibLights AS3677 LCD === */
char const*const LCD_BACKLIGHT1_FILE              = "/sys/devices/i2c-10/10-0040/leds/lcd-backlight1/brightness";
char const*const LCD_BACKLIGHT2_FILE              = "/sys/devices/i2c-10/10-0040/leds/lcd-backlight2/brightness";
char const*const MAX_BRIGHTNESS_FILE              = "/sys/devices/i2c-10/10-0040/leds/lcd-backlight1/max_brightness";
const int LCD_BRIGHTNESS_MAX                      = 255;
const int LCD_BRIGHTNESS_MIN                      = 1;
const int LCD_BRIGHTNESS_OFF                      = 0;

/* ===================================================================== */
/* === LibLights AS3665 LEDs === */
char const*const LEDS_COLORS_BRIGHTNESS_FILE      = "/sys/class/leds/LED%d_%c/brightness";
char const*const LEDS_COLORS_CURRENT_FILE         = "/sys/class/leds/LED%d_%c/led_current";
char const*const LEDS_COLORS_DELAYON_FILE         = "/sys/class/leds/LED%d_%c/delay_on";
char const*const LEDS_COLORS_DELAYOFF_FILE        = "/sys/class/leds/LED%d_%c/delay_off";
const int LEDS_COLORS_CURRENT_MAX_CHARGING        = 15;
const int LEDS_COLORS_CURRENT_MAX_NOTIFICATIONS   = 255;

/* ===================================================================== */
/* === LibLights AS3665 Sequencer === */
char const*const LEDS_SEQUENCER1_MODE_FILE        = "/sys/devices/i2c-10/10-0047/sequencer1_mode";
char const*const LEDS_SEQUENCER2_MODE_FILE        = "/sys/devices/i2c-10/10-0047/sequencer2_mode";
char const*const LEDS_SEQUENCER3_MODE_FILE        = "/sys/devices/i2c-10/10-0047/sequencer3_mode";
char const*const LEDS_SEQUENCER1_RUN_FILE         = "/sys/devices/i2c-10/10-0047/sequencer1_run_mode";
char const*const LEDS_SEQUENCER2_RUN_FILE         = "/sys/devices/i2c-10/10-0047/sequencer2_run_mode";
char const*const LEDS_SEQUENCER3_RUN_FILE         = "/sys/devices/i2c-10/10-0047/sequencer3_run_mode";
char const*const LEDS_SEQUENCER_LOAD_FILE         = "/sys/devices/i2c-10/10-0047/sequencer_load";

/* ===================================================================== */
/* === LibLights AS3665 Audio === */
char const*const LEDS_AUDIO_AGC_CTRL_FILE         = "/sys/devices/i2c-10/10-0047/audio_agc_ctrl";
char const*const LEDS_AUDIO_AGC_TIME_FILE         = "/sys/devices/i2c-10/10-0047/audio_agc_time";
char const*const LEDS_AUDIO_BUF_GAIN_FILE         = "/sys/devices/i2c-10/10-0047/audio_buf_gain";
char const*const LEDS_AUDIO_ENABLE_FILE           = "/sys/devices/i2c-10/10-0047/audio_en";
const int LEDS_AUDIO_AGC_CTRL                     = 7;
const int LEDS_AUDIO_AGC_TIME                     = 0;
const int LEDS_AUDIO_BUF_GAIN                     = 4;

/* ===================================================================== */
/* === LibAls AS3677 LCD === */
char const*const AS3677_ALS_LUX_FILE              = "/sys/devices/i2c-10/10-0040/adc_als_value";
char const*const AS3677_ALS_ENABLE_FILE           = "/sys/devices/i2c-10/10-0040/als_on";
char const*const AS3677_ALS_GROUP1_FILE           = "/sys/devices/i2c-10/10-0040/als_group1";
char const*const AS3677_ALS_LCD1_GROUP_FILE       = "/sys/devices/i2c-10/10-0040/leds/lcd-backlight1/als_group";
char const*const AS3677_ALS_LCD2_GROUP_FILE       = "/sys/devices/i2c-10/10-0040/leds/lcd-backlight2/als_group";
char const*const ALS_LCD_LEVELS_GROUP1            = "60,6,39,89,17,255,0";

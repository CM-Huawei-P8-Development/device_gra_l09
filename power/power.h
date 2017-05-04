/*
 * Copyright (C) 2016 The CyanogenMod Project
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

#define LOG_TAG "HI3635 PowerHAL"

#define STATE_ON "state=1"

#define KERNEL_HMP_PATH "/sys/kernel/hmp/"
#define DDRFREQ__PATH	"/sys/class/devfreq/ddrfreq"
#define GPUFREQ_PATH "/sys/class/devfreq/gpufreq/"
#define GPU_ONDEMAND_PATH	"/sys/class/devfreq/gpufreq/mali_ondemand"

#define CPUFREQ_PATH0 "/sys/devices/system/cpu/cpu0/cpufreq/"
#define CPUFREQ_PATH1 "/sys/devices/system/cpu/cpu4/cpufreq/"

#define INTERACTIVE_PATH0 "/sys/devices/system/cpu/cpu0/cpufreq/interactive/"
#define INTERACTIVE_PATH1 "/sys/devices/system/cpu/cpu4/cpufreq/interactive/"

#define ONDEMAND_PATH0 "/sys/devices/system/cpu/cpu0/cpufreq/ondemand/"
#define ONDEMAND_PATH1 "/sys/devices/system/cpu/cpu4/cpufreq/ondemand/"

#define TAP_TO_WAKE_NODE "/sys/touchscreen/easy_wakeup_gesture"
#define TAP_TO_WAKE_ENABLE "/sys/touchscreen/wakeup_gesture_enable"

#define VID_ENC_TIMER_RATE 30000
#define VID_ENC_IO_IS_BUSY 0

enum {
    PROFILE_POWER_SAVE = 0,
    PROFILE_BALANCED,
    PROFILE_HIGH_PERFORMANCE,
    PROFILE_MAX
};

typedef struct interactive_governor_settings {
    int go_hispeed_load;
    int hispeed_freq;
    int io_is_busy;
    int boostpulse_duration;
    char *target_loads;
    int scaling_min_freq;
    int scaling_max_freq;
} power_profile_cpu0;

typedef struct ondemand_governor_settings {
    int io_is_busy;
    int sampling_down_factor;
    int sampling_rate;
    int up_threshold;
    int scaling_min_freq;
    int scaling_max_freq;
} power_profile_cpu4;

typedef struct other_settings {
    int hmp_up;
    int hmp_down;
    int hmp_prio;
    unsigned long ddr_max_freq;
    unsigned long ddr_min_freq;
    int ddr_polling_interval;
    unsigned long gpu_max_freq;
    unsigned long gpu_min_freq;
    int gpu_polling_interval;
    int animation_boost;
    unsigned long animation_boost_freq;
} power_profile_other;

static power_profile_cpu0 profiles0[PROFILE_MAX] = {
    [PROFILE_POWER_SAVE] = {
        .go_hispeed_load = 99,
        .hispeed_freq = 1209600,
        .io_is_busy = 0,
        .boostpulse_duration = 80000,
        .target_loads = "95",
        .scaling_min_freq = 403200,
        .scaling_max_freq = 806400,
    },
    [PROFILE_BALANCED] = {
        .go_hispeed_load = 99,
        .hispeed_freq = 1209600,
        .io_is_busy = 1,
        .boostpulse_duration = 80000,
        .target_loads = "70:604800:75:806400:90:1209600:95",
        .scaling_min_freq = 403200,
        .scaling_max_freq = 1516800,
    },
    [PROFILE_HIGH_PERFORMANCE] = {
        .go_hispeed_load = 95,
        .hispeed_freq = 1516800,
        .io_is_busy = 1,
        .boostpulse_duration = 160000,
        .target_loads = "30:604800:40:806400:50:1209600:85",
        .scaling_min_freq = 403200,
        .scaling_max_freq = 1516800,
    },
};

static power_profile_cpu4 profiles1[PROFILE_MAX] = {
    [PROFILE_POWER_SAVE] = {
        .io_is_busy = 0,
        .sampling_down_factor = 1,
        .sampling_rate = 10000,
        .up_threshold = 99,
        .scaling_min_freq = 1017600,
        .scaling_max_freq = 1209600,
    },
    [PROFILE_BALANCED] = {
        .io_is_busy = 1,
        .sampling_down_factor = 1,
        .sampling_rate = 10000,
        .up_threshold = 99,
        .scaling_min_freq = 1017600,
        .scaling_max_freq = 2016000,
    },
    [PROFILE_HIGH_PERFORMANCE] = {
        .io_is_busy = 1,
        .sampling_down_factor = 4,
        .sampling_rate = 50000,
        .up_threshold = 85,
        .scaling_min_freq = 1017600,
        .scaling_max_freq = 2016000,
    },
};

static power_profile_other profiles2[PROFILE_MAX] = {
    [PROFILE_POWER_SAVE] = {
        .hmp_up = 1008,
        .hmp_down = 768,
        .hmp_prio = 140,
        .ddr_max_freq = 360000000,
        .ddr_min_freq = 120000000,
        .ddr_polling_interval = 20,
        .gpu_max_freq = 360000000,
        .gpu_min_freq = 288000000,
        .gpu_polling_interval = 20,
        .animation_boost = 0,
        .animation_boost_freq = 480000000,
    },
    [PROFILE_BALANCED] = {
        .hmp_up = 978,
        .hmp_down = 672,
        .hmp_prio = 140,
        .ddr_max_freq = 667000000,
        .ddr_min_freq = 120000000,
        .ddr_polling_interval = 40,
        .gpu_max_freq = 480000000,
        .gpu_min_freq = 288000000,
        .gpu_polling_interval = 40,
        .animation_boost = 1,
        .animation_boost_freq = 600000000,
    },
    [PROFILE_HIGH_PERFORMANCE] = {
        .hmp_up = 500,
        .hmp_down = 200,
        .hmp_prio = 140,
        .ddr_max_freq = 800000000,
        .ddr_min_freq = 120000000,
        .ddr_polling_interval = 50,
        .gpu_max_freq = 600000000,
        .gpu_min_freq = 288000000,
        .gpu_polling_interval = 50,
        .animation_boost = 1,
        .animation_boost_freq = 680000000,
    },
};

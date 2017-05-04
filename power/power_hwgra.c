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
#include <hardware/hardware.h>
#include <hardware/power.h>

#include <stdbool.h>
#include <errno.h>
#include <fcntl.h>
#include <string.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#include <utils/Log.h>
#include "property_service.h"

#include "power.h"

static pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
static int boostpulse_fd = -1;
static int current_power_profile = 1;
static int low_power = 0;
static int dt2w = 0;

static int sysfs_write_str(char *path, char *s)
{
    char buf[80];
    int len;
    int ret = 0;
    int fd;

    fd = open(path, O_WRONLY);
    if (fd < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGE("Error opening %s: %s\n", path, buf);
        return -1 ;
    }

    len = write(fd, s, strlen(s));
    if (len < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGE("Error writing to %s: %s\n", path, buf);
        ret = -1;
    }

    close(fd);

    return ret;
}

static int sysfs_write_int(char *path, int value)
{
    char buf[80];
    snprintf(buf, 80, "%d", value);
    return sysfs_write_str(path, buf);
}

static bool check_governor(void)
{
    struct stat s;
    int err = stat(INTERACTIVE_PATH0, &s);
    if (err != 0) return false;
    if (S_ISDIR(s.st_mode)) return true;
    return false;
}

static int is_profile_valid(int profile)
{
    if (profile >= 0 && profile < PROFILE_MAX)
	return profile;
    else
	return -1;
}

static void power_init(__attribute__((unused)) struct power_module *module)
{
    ALOGI("%s", __func__);
}

static int boostpulse_open()
{
    pthread_mutex_lock(&lock);
    if (boostpulse_fd < 0) {
        boostpulse_fd = open(INTERACTIVE_PATH0 "boostpulse", O_WRONLY);
    }
    pthread_mutex_unlock(&lock);

    return boostpulse_fd;
}

static void power_set_interactive(__attribute__((unused)) struct power_module *module, int on)
{
    if (is_profile_valid(current_power_profile) < 0) {
        ALOGD("%s: no power profile selected yet", __func__);
        return;
    }

    // break out early if governor is not interactive
    if (!check_governor()) return;

    if (on && !low_power) {
        sysfs_write_int(INTERACTIVE_PATH0 "go_hispeed_load",
                      profiles0[current_power_profile].go_hispeed_load);
        sysfs_write_int(INTERACTIVE_PATH0 "hispeed_freq",
                        profiles0[current_power_profile].hispeed_freq);
        sysfs_write_int(INTERACTIVE_PATH0 "io_is_busy",
                      profiles0[current_power_profile].io_is_busy);
        sysfs_write_int(INTERACTIVE_PATH0 "boostpulse_duration",
                        profiles0[current_power_profile].boostpulse_duration);
        sysfs_write_str(INTERACTIVE_PATH0 "target_loads",
                        profiles0[current_power_profile].target_loads);
        sysfs_write_int(CPUFREQ_PATH0 "scaling_min_freq",
                        profiles0[current_power_profile].scaling_min_freq);
        sysfs_write_int(CPUFREQ_PATH0 "scaling_max_freq",
                        profiles0[current_power_profile].scaling_max_freq);

        sysfs_write_int(ONDEMAND_PATH1 "io_is_busy",
                        profiles1[current_power_profile].io_is_busy);
        sysfs_write_int(ONDEMAND_PATH1 "sampling_down_factor",
                        profiles1[current_power_profile].sampling_down_factor);
        sysfs_write_int(ONDEMAND_PATH1 "sampling_rate",
                        profiles1[current_power_profile].sampling_rate);
        sysfs_write_int(ONDEMAND_PATH1 "up_threshold",
                        profiles1[current_power_profile].up_threshold);
        sysfs_write_int(CPUFREQ_PATH1 "scaling_min_freq",
                        profiles0[current_power_profile].scaling_min_freq);
        sysfs_write_int(CPUFREQ_PATH1 "scaling_max_freq",
                        profiles0[current_power_profile].scaling_max_freq);

        sysfs_write_int(KERNEL_HMP_PATH "hmp_up",
                        profiles2[current_power_profile].hmp_up);
        sysfs_write_int(KERNEL_HMP_PATH "hmp_down",
                        profiles2[current_power_profile].hmp_down);
        sysfs_write_int(KERNEL_HMP_PATH "hmp_prio",
                        profiles2[current_power_profile].hmp_prio);

        sysfs_write_int(DDRFREQ__PATH "min_freq",
                        profiles2[current_power_profile].ddr_min_freq);
        sysfs_write_int(DDRFREQ__PATH "max_freq",
                        profiles2[current_power_profile].ddr_max_freq);
        sysfs_write_int(DDRFREQ__PATH "polling_interval",
                        profiles2[current_power_profile].ddr_polling_interval);

        sysfs_write_int(GPUFREQ_PATH "min_freq",
                        profiles2[current_power_profile].gpu_min_freq);
        sysfs_write_int(GPUFREQ_PATH "max_freq",
                        profiles2[current_power_profile].gpu_max_freq);
        sysfs_write_int(GPUFREQ_PATH "polling_interval",
                        profiles2[current_power_profile].gpu_polling_interval);
        sysfs_write_int(GPU_ONDEMAND_PATH "animation_boost",
                        profiles2[current_power_profile].animation_boost);
        sysfs_write_int(GPU_ONDEMAND_PATH "animation_boost_freq",
                        profiles2[current_power_profile].animation_boost_freq);
    } else {
      sysfs_write_int(INTERACTIVE_PATH0 "go_hispeed_load",
                    profiles0[PROFILE_BALANCED].go_hispeed_load);
      sysfs_write_int(INTERACTIVE_PATH0 "hispeed_freq",
                      profiles0[PROFILE_BALANCED].hispeed_freq);
      sysfs_write_int(INTERACTIVE_PATH0 "io_is_busy",
                    profiles0[PROFILE_BALANCED].io_is_busy);
      sysfs_write_int(INTERACTIVE_PATH0 "boostpulse_duration",
                      profiles0[PROFILE_BALANCED].boostpulse_duration);
      sysfs_write_str(INTERACTIVE_PATH0 "target_loads",
                      profiles0[PROFILE_BALANCED].target_loads);
      sysfs_write_int(CPUFREQ_PATH0 "scaling_min_freq",
                      profiles0[PROFILE_BALANCED].scaling_min_freq);
      sysfs_write_int(CPUFREQ_PATH0 "scaling_max_freq",
                      profiles0[PROFILE_BALANCED].scaling_max_freq);

      sysfs_write_int(ONDEMAND_PATH1 "io_is_busy",
                      profiles1[PROFILE_BALANCED].io_is_busy);
      sysfs_write_int(ONDEMAND_PATH1 "sampling_down_factor",
                      profiles1[PROFILE_BALANCED].sampling_down_factor);
      sysfs_write_int(ONDEMAND_PATH1 "sampling_rate",
                      profiles1[PROFILE_BALANCED].sampling_rate);
      sysfs_write_int(ONDEMAND_PATH1 "up_threshold",
                      profiles1[PROFILE_BALANCED].up_threshold);
      sysfs_write_int(CPUFREQ_PATH1 "scaling_min_freq",
                      profiles0[PROFILE_BALANCED].scaling_min_freq);
      sysfs_write_int(CPUFREQ_PATH1 "scaling_max_freq",
                      profiles0[PROFILE_BALANCED].scaling_max_freq);

      sysfs_write_int(KERNEL_HMP_PATH "hmp_up",
                      profiles2[PROFILE_BALANCED].hmp_up);
      sysfs_write_int(KERNEL_HMP_PATH "hmp_down",
                      profiles2[PROFILE_BALANCED].hmp_down);
      sysfs_write_int(KERNEL_HMP_PATH "hmp_prio",
                      profiles2[PROFILE_BALANCED].hmp_prio);

      sysfs_write_int(DDRFREQ__PATH "min_freq",
                      profiles2[PROFILE_BALANCED].ddr_min_freq);
      sysfs_write_int(DDRFREQ__PATH "max_freq",
                      profiles2[PROFILE_BALANCED].ddr_max_freq);
      sysfs_write_int(DDRFREQ__PATH "polling_interval",
                      profiles2[PROFILE_BALANCED].ddr_polling_interval);

      sysfs_write_int(GPUFREQ_PATH "min_freq",
                      profiles2[PROFILE_BALANCED].gpu_min_freq);
      sysfs_write_int(GPUFREQ_PATH "max_freq",
                      profiles2[PROFILE_BALANCED].gpu_max_freq);
      sysfs_write_int(GPUFREQ_PATH "polling_interval",
                      profiles2[PROFILE_BALANCED].gpu_polling_interval);
      sysfs_write_int(GPU_ONDEMAND_PATH "animation_boost",
                      profiles2[PROFILE_BALANCED].animation_boost);
      sysfs_write_int(GPU_ONDEMAND_PATH "animation_boost_freq",
                      profiles2[PROFILE_BALANCED].animation_boost_freq);
        if(dt2w) sysfs_write_int(TAP_TO_WAKE_ENABLE,1);
    }
}

static void set_power_profile(int profile)
{
    if (is_profile_valid(profile) < 0) {
        ALOGE("%s: unknown profile: %d", __func__, profile);
        return;
    }

    // break out early if governor is not interactive
    if (!check_governor()) return;

    if (profile == current_power_profile)
        return;

    ALOGD("%s: setting profile %d", __func__, profile);

    sysfs_write_int(INTERACTIVE_PATH0 "go_hispeed_load",
                  profiles0[profile].go_hispeed_load);
    sysfs_write_int(INTERACTIVE_PATH0 "hispeed_freq",
                    profiles0[profile].hispeed_freq);
    sysfs_write_int(INTERACTIVE_PATH0 "io_is_busy",
                  profiles0[profile].io_is_busy);
    sysfs_write_int(INTERACTIVE_PATH0 "boostpulse_duration",
                    profiles0[profile].boostpulse_duration);
    sysfs_write_str(INTERACTIVE_PATH0 "target_loads",
                    profiles0[profile].target_loads);
    sysfs_write_int(CPUFREQ_PATH0 "scaling_min_freq",
                    profiles0[profile].scaling_min_freq);
    sysfs_write_int(CPUFREQ_PATH0 "scaling_max_freq",
                    profiles0[profile].scaling_max_freq);

    sysfs_write_int(ONDEMAND_PATH1 "io_is_busy",
                    profiles1[profile].io_is_busy);
    sysfs_write_int(ONDEMAND_PATH1 "sampling_down_factor",
                    profiles1[profile].sampling_down_factor);
    sysfs_write_int(ONDEMAND_PATH1 "sampling_rate",
                    profiles1[profile].sampling_rate);
    sysfs_write_int(ONDEMAND_PATH1 "up_threshold",
                    profiles1[profile].up_threshold);
    sysfs_write_int(CPUFREQ_PATH1 "scaling_min_freq",
                    profiles0[profile].scaling_min_freq);
    sysfs_write_int(CPUFREQ_PATH1 "scaling_max_freq",
                    profiles0[profile].scaling_max_freq);

    sysfs_write_int(KERNEL_HMP_PATH "hmp_up",
                    profiles2[profile].hmp_up);
    sysfs_write_int(KERNEL_HMP_PATH "hmp_down",
                    profiles2[profile].hmp_down);
    sysfs_write_int(KERNEL_HMP_PATH "hmp_prio",
                    profiles2[profile].hmp_prio);

    sysfs_write_int(DDRFREQ__PATH "min_freq",
                    profiles2[profile].ddr_min_freq);
    sysfs_write_int(DDRFREQ__PATH "max_freq",
                    profiles2[profile].ddr_max_freq);
    sysfs_write_int(DDRFREQ__PATH "polling_interval",
                    profiles2[profile].ddr_polling_interval);

    sysfs_write_int(GPUFREQ_PATH "min_freq",
                    profiles2[profile].gpu_min_freq);
    sysfs_write_int(GPUFREQ_PATH "max_freq",
                    profiles2[profile].gpu_max_freq);
    sysfs_write_int(GPUFREQ_PATH "polling_interval",
                    profiles2[profile].gpu_polling_interval);
    sysfs_write_int(GPU_ONDEMAND_PATH "animation_boost",
                    profiles2[profile].animation_boost);
    sysfs_write_int(GPU_ONDEMAND_PATH "animation_boost_freq",
                    profiles2[profile].animation_boost_freq);

    current_power_profile = profile;
}

static void power_hint_low_power(int on) {
    low_power = on;
    if(on) {
      /*
      * USE POWER_SAVE SETTINGS BUT SET POLLING_INTERVAL TO 0
      * ALSO SET MAX_FREQ FOR BOTH CPU SETS, GPU AND DDR TO THE SAME VALUE
      * USED FOR MIN_FREQ TO SAVE BATTERY
       */
      sysfs_write_int(INTERACTIVE_PATH0 "go_hispeed_load",
                      profiles0[PROFILE_POWER_SAVE].go_hispeed_load);
      sysfs_write_int(INTERACTIVE_PATH0 "hispeed_freq",
                      profiles0[PROFILE_POWER_SAVE].hispeed_freq);
      sysfs_write_int(INTERACTIVE_PATH0 "io_is_busy",
                      profiles0[PROFILE_POWER_SAVE].io_is_busy);
      sysfs_write_int(INTERACTIVE_PATH0 "boostpulse_duration",
                      profiles0[PROFILE_POWER_SAVE].boostpulse_duration);
      sysfs_write_str(INTERACTIVE_PATH0 "target_loads",
                      profiles0[PROFILE_POWER_SAVE].target_loads);
      sysfs_write_int(CPUFREQ_PATH0 "scaling_min_freq",
                      profiles0[PROFILE_POWER_SAVE].scaling_min_freq);
      sysfs_write_int(CPUFREQ_PATH0 "scaling_max_freq",
                      profiles0[PROFILE_POWER_SAVE].scaling_min_freq);

      sysfs_write_int(ONDEMAND_PATH1 "io_is_busy",
                      profiles1[PROFILE_POWER_SAVE].io_is_busy);
      sysfs_write_int(ONDEMAND_PATH1 "sampling_down_factor",
                      profiles1[PROFILE_POWER_SAVE].sampling_down_factor);
      sysfs_write_int(ONDEMAND_PATH1 "sampling_rate",
                      profiles1[PROFILE_POWER_SAVE].sampling_rate);
      sysfs_write_int(ONDEMAND_PATH1 "up_threshold",
                      profiles1[PROFILE_POWER_SAVE].up_threshold);
      sysfs_write_int(CPUFREQ_PATH1 "scaling_min_freq",
                      profiles0[PROFILE_POWER_SAVE].scaling_min_freq);
      sysfs_write_int(CPUFREQ_PATH1 "scaling_max_freq",
                      profiles0[PROFILE_POWER_SAVE].scaling_min_freq);

      sysfs_write_int(KERNEL_HMP_PATH "hmp_up",
                      profiles2[PROFILE_POWER_SAVE].hmp_up);
      sysfs_write_int(KERNEL_HMP_PATH "hmp_down",
                      profiles2[PROFILE_POWER_SAVE].hmp_down);
      sysfs_write_int(KERNEL_HMP_PATH "hmp_prio",
                      profiles2[PROFILE_POWER_SAVE].hmp_prio);

      sysfs_write_int(DDRFREQ__PATH "min_freq",
                      profiles2[PROFILE_POWER_SAVE].ddr_min_freq);
      sysfs_write_int(DDRFREQ__PATH "max_freq",
                      profiles2[PROFILE_POWER_SAVE].ddr_min_freq);
      sysfs_write_int(DDRFREQ__PATH "polling_interval", 0);

      sysfs_write_int(GPUFREQ_PATH "min_freq",
                      profiles2[PROFILE_POWER_SAVE].gpu_min_freq);
      sysfs_write_int(GPUFREQ_PATH "max_freq",
                      profiles2[PROFILE_POWER_SAVE].gpu_min_freq);
      sysfs_write_int(GPUFREQ_PATH "polling_interval", 0);
      sysfs_write_int(GPU_ONDEMAND_PATH "animation_boost",
                      profiles2[PROFILE_POWER_SAVE].animation_boost);
      sysfs_write_int(GPU_ONDEMAND_PATH "animation_boost_freq",
                      profiles2[PROFILE_POWER_SAVE].animation_boost_freq);
    } else {
      sysfs_write_int(INTERACTIVE_PATH0 "go_hispeed_load",
                      profiles0[current_power_profile].go_hispeed_load);
      sysfs_write_int(INTERACTIVE_PATH0 "hispeed_freq",
                      profiles0[current_power_profile].hispeed_freq);
      sysfs_write_int(INTERACTIVE_PATH0 "io_is_busy",
                      profiles0[current_power_profile].io_is_busy);
      sysfs_write_int(INTERACTIVE_PATH0 "boostpulse_duration",
                      profiles0[current_power_profile].boostpulse_duration);
      sysfs_write_str(INTERACTIVE_PATH0 "target_loads",
                      profiles0[current_power_profile].target_loads);
      sysfs_write_int(CPUFREQ_PATH0 "scaling_min_freq",
                      profiles0[current_power_profile].scaling_min_freq);
      sysfs_write_int(CPUFREQ_PATH0 "scaling_max_freq",
                      profiles0[current_power_profile].scaling_max_freq);

      sysfs_write_int(ONDEMAND_PATH1 "io_is_busy",
                      profiles1[current_power_profile].io_is_busy);
      sysfs_write_int(ONDEMAND_PATH1 "sampling_down_factor",
                      profiles1[current_power_profile].sampling_down_factor);
      sysfs_write_int(ONDEMAND_PATH1 "sampling_rate",
                      profiles1[current_power_profile].sampling_rate);
      sysfs_write_int(ONDEMAND_PATH1 "up_threshold",
                      profiles1[current_power_profile].up_threshold);
      sysfs_write_int(CPUFREQ_PATH1 "scaling_min_freq",
                      profiles0[current_power_profile].scaling_min_freq);
      sysfs_write_int(CPUFREQ_PATH1 "scaling_max_freq",
                      profiles0[current_power_profile].scaling_max_freq);

      sysfs_write_int(KERNEL_HMP_PATH "hmp_up",
                      profiles2[current_power_profile].hmp_up);
      sysfs_write_int(KERNEL_HMP_PATH "hmp_down",
                      profiles2[current_power_profile].hmp_down);
      sysfs_write_int(KERNEL_HMP_PATH "hmp_prio",
                      profiles2[current_power_profile].hmp_prio);

      sysfs_write_int(DDRFREQ__PATH "min_freq",
                      profiles2[current_power_profile].ddr_min_freq);
      sysfs_write_int(DDRFREQ__PATH "max_freq",
                      profiles2[current_power_profile].ddr_max_freq);
      sysfs_write_int(DDRFREQ__PATH "polling_interval",
                      profiles2[current_power_profile].ddr_polling_interval);

      sysfs_write_int(GPUFREQ_PATH "min_freq",
                      profiles2[current_power_profile].gpu_min_freq);
      sysfs_write_int(GPUFREQ_PATH "max_freq",
                      profiles2[current_power_profile].gpu_max_freq);
      sysfs_write_int(GPUFREQ_PATH "polling_interval",
                      profiles2[current_power_profile].gpu_polling_interval);
      sysfs_write_int(GPU_ONDEMAND_PATH "animation_boost",
                      profiles2[current_power_profile].animation_boost);
      sysfs_write_int(GPU_ONDEMAND_PATH "animation_boost_freq",
                      profiles2[current_power_profile].animation_boost_freq);
    }
}

static void process_video_encode_hint(void *metadata)
{
    int on;

    if (!metadata)
        return;

    /* Break out early if governor is not interactive */
    if (!check_governor())
        return;

    on = !strncmp(metadata, STATE_ON, sizeof(STATE_ON));

    sysfs_write_int(INTERACTIVE_PATH0 "timer_rate", on ?
            VID_ENC_TIMER_RATE : 20000);

    sysfs_write_int(INTERACTIVE_PATH0 "io_is_busy", on ?
            VID_ENC_IO_IS_BUSY :
            profiles0[current_power_profile].io_is_busy);
    sysfs_write_int(INTERACTIVE_PATH1 "io_is_busy", on ?
            VID_ENC_IO_IS_BUSY :
            profiles1[current_power_profile].io_is_busy);
}

static void power_hint(__attribute__((unused)) struct power_module *module,
                       power_hint_t hint, void *data)
{
    char buf[80];
    int len;

    switch (hint) {
    case POWER_HINT_INTERACTION:
    case POWER_HINT_LAUNCH_BOOST:
    case POWER_HINT_CPU_BOOST:
        if(low_power)
            return;
        if (is_profile_valid(current_power_profile) < 0) {
            ALOGD("%s: no power profile selected yet", __func__);
            return;
        }

        if (!profiles0[current_power_profile].boostpulse_duration)
            return;

        // break out early if governor is not interactive
        if (!check_governor()) return;

        if (boostpulse_open() >= 0) {
            snprintf(buf, sizeof(buf), "%d", 1);
            len = write(boostpulse_fd, &buf, sizeof(buf));
            if (len < 0) {
                strerror_r(errno, buf, sizeof(buf));
                ALOGE("Error writing to boostpulse: %s\n", buf);

                pthread_mutex_lock(&lock);
                close(boostpulse_fd);
                boostpulse_fd = -1;
                pthread_mutex_unlock(&lock);
            }
        }
        break;
    case POWER_HINT_SET_PROFILE:
        pthread_mutex_lock(&lock);
        set_power_profile(*(int32_t *)data);
        pthread_mutex_unlock(&lock);
        break;
    case POWER_HINT_VIDEO_ENCODE:
        pthread_mutex_lock(&lock);
        if(!low_power)
            process_video_encode_hint(data);
        pthread_mutex_unlock(&lock);
        break;
    case POWER_HINT_LOW_POWER:
        pthread_mutex_lock(&lock);
    		power_hint_low_power(*(int32_t *)data);
        pthread_mutex_unlock(&lock);
    		break;
    default:
        break;
    }
}

static struct hw_module_methods_t power_module_methods = {
    .open = NULL,
};

static void set_dt2w(int on) {
    dt2w = on;
    if(on)
	     sysfs_write_int(TAP_TO_WAKE_NODE,1);
    else
	     sysfs_write_int(TAP_TO_WAKE_NODE,0);
}

static int get_feature(__attribute__((unused)) struct power_module *module,
                       feature_t feature)
{
    int ret = -1;
    switch (feature) {
      case POWER_FEATURE_DOUBLE_TAP_TO_WAKE:
        ret = 1;
        break;
    case POWER_FEATURE_SUPPORTED_PROFILES:
	     ret = PROFILE_MAX;
	     break;
    default:
        break;
    }
    return ret;
}

static void set_feature(__attribute__((unused)) struct power_module *module,
                       feature_t feature, int mode)
{
    switch (feature) {
    case POWER_FEATURE_DOUBLE_TAP_TO_WAKE:
        set_dt2w(mode);
        ALOGI("POWER_FEATURE_DOUBLE_TAP_TO_WAKE: %d",mode);
        break;
    case POWER_FEATURE_SUPPORTED_PROFILES:
        ALOGI("POWER_FEATURE_SUPPORTED_PROFILES: %d",mode);
	      break;
    default:
        break;
    }
}

struct power_module HAL_MODULE_INFO_SYM = {
    .common = {
        .tag = HARDWARE_MODULE_TAG,
        .module_api_version = POWER_MODULE_API_VERSION_0_3,
        .hal_api_version = HARDWARE_HAL_API_VERSION,
        .id = POWER_HARDWARE_MODULE_ID,
        .name = "HI3635 Power HAL",
        .author = "Surdu Petru, Andrea Dieni",
        .methods = &power_module_methods,
    },

    .init = power_init,
    .setInteractive = power_set_interactive,
    .powerHint = power_hint,
    .setFeature = set_feature,
    .getFeature = get_feature
};

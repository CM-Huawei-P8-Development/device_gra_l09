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



/*
NOTE:
-----
This was just a incomplete try. For the moment I leave it in place.
It isn't actually built or used at all.

*/


#define LOG_TAG "RILD_SHIM"
#define MAX_SOCKET_NAME_LENGTH 6
#define SOCKET_NAME_RIL "rild"
#include <utils/Log.h>
#include <stdbool.h>

/*
* Use: reads the property ro.config.full_network_support
* Notice: required by libbalong-ril.so
*/
bool isCommrilSupportFullNetwork(void){
    ALOGD("!!SHIM!! libbalong-ril.so-->libril.so/isCommrilSupportFullNetwork-->ro.config.full_network_support return true");
    return true;
}

/*
* Use: Not sure
* Notice: required by libbalong-ril.so | This actually exists in the google source.
*/
char rild[MAX_SOCKET_NAME_LENGTH] = SOCKET_NAME_RIL;
char * Ril_GetRilSocketName(void){
    ALOGD("!!SHIM!! libbalong-ril.so-->libril.so/Ril_GetRilSocketName--> return rild");
    return rild;
}


/*
* Use: set/change the IMEI?
* Notice: required by libbalong-ril.so
*/
void RIL_set_imei(void){
    ALOGD("!!SHIM!! libbalong-ril.so-->libril.so/RIL_set_imei");
}



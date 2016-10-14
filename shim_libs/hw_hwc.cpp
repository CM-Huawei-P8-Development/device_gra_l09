 /*
 * Copyright (C) 2015 The CyanogenMod Project
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
 *
 * Shim lib to override corrupt functions in hwcomposer.hi3635 for gra-l09
 * by nexolight
 */

#define LOG_TAG "SHIM_HWC" 
#include <stdint.h>
//#include <dlfcn.h>
#include <utils/Log.h>
//#include <android/rect.h>
//#include <hardware/hwcomposer_defs.h>

/*
class HwcPartialUpdates{
	public: 
	static bool UpdateSourceLayer(struct hwc_layer_1 *sourcelayers);
	static bool is_format_change(HwcCompInfo const*, hwc_display_contents_1 const*);
};
*/
/*
* Purpose:
* If there is any display damage add all the rects with android::Region::addRectUnchecked
* (is a loop) Also check if android::Rect::intersect (not a loop) is true
* 
* If so update the source
* HwcPartialUpdates::UpdateSourceCrop(hwc_layer_1*, hwc_rect const*) (hwc_rect = hwc_layer_1[6]) and
* HwcPartialUpdates::UpdateDisplayFrame(hwc_layer_1*)
* and return true/1
*
* otherwise return false/0
*/
/*
bool HwcPartialUpdates::UpdateSourceLayer(struct hwc_layer_1 *sourcelayers){

	typedef void(*MyFunction1)();
	static MyFunction1 origFunction=0;
	void *tmpPtr = dlsym(RTLD_NEXT, "_ZN17HwcPartialUpdates17UpdateSourceLayerEP11hwc_layer_1");
	memcpy(&origFunction, &tmpPtr, sizeof(void *));
	//return (*origFunction)();
	ALOGD("Using broken function HwcPartialUpdates::UpdateSourceLayer");
	return false;
}
*/


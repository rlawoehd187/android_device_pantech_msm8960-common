/*
   Copyright (c) 2016, The LineageOS Project
   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.
   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>
#include <android-base/logging.h>
#include <android-base/properties.h>

#include "vendor_init.h"
#include "property_service.h"

using android::base::GetProperty;

#define ISMATCH(a,b)    (!strncmp(a,b,PROP_VALUE_MAX))

void property_override(char const prop[], char const value[])
{
    prop_info *pi;

    pi = (prop_info*) __system_property_find(prop);
    if (pi)
        __system_property_update(pi, value, strlen(value));
    else
        __system_property_add(prop, strlen(prop), value, strlen(value));
}

void vendor_load_properties()
{
    int n = 0;
    char device_buf[PROP_VALUE_MAX];
    FILE *fp = NULL;

    std::string platform = GetProperty("ro.board.platform", "");
    if (platform != ANDROID_TARGET)
        return;

    fp = fopen("/dev/block/platform/msm_sdcc.1/by-name/rawdata", "r");
    if ( fp == NULL )
    {
        return;
    }
    else
    {
        fseek(fp,0x24,SEEK_SET);
        n = fread(device_buf, 8, 1, fp);
        device_buf[8] = '\0';        
        fclose(fp);
    }
	//Prop for ril class
	property_override("ro.telephony.ril_class", "SkyHLRIL");

    property_override("ro.product.model", device_buf);
	// A870
    if (strstr(device_buf, "IM-A870S")) 
    {
        property_override("ro.product.device", "ef52s");
    } 
    else if (strstr(device_buf, "IM-A870K")) 
    {
        property_override("ro.product.device", "ef52k");
    } 
    else if (strstr(device_buf, "IM-A870L"))
    {
        property_override("ro.product.device", "ef52l");
		property_override("telephony.lteOnCdmaDevice", "1"); //Only L device support CDMA-2000 1xEV-DO
    }
    //A860
    if (strstr(device_buf, "IM-A860S")) 
    {
        property_override("ro.product.device", "ef51l");
    } 
    else if (strstr(device_buf, "IM-A860K")) 
    {
        property_override("ro.product.device", "ef51k");
    } 
    else if (strstr(device_buf, "IM-A860L"))
    {
        property_override("ro.product.device", "ef51l");
		property_override("telephony.lteOnCdmaDevice", "1"); //Only L device support CDMA-2000 1xEV-DO
    }
	// A850
    if (strstr(device_buf, "IM-A850S")) 
    {
        property_override("ro.product.device", "ef48s");
    } 
    else if (strstr(device_buf, "IM-A850K")) 
    {
        property_override("ro.product.device", "ef49k");
    } 
    else if (strstr(device_buf, "IM-A850L"))
    {
        property_override("ro.product.device", "ef50l");
		property_override("telephony.lteOnCdmaDevice", "1"); //Only L device support CDMA-2000 1xEV-DO
    }
}

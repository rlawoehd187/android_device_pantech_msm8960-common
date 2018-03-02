/*
 * Copyright (C) 2012 The CyanogenMod Project
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

package com.android.internal.telephony;

import android.os.Message;
import android.os.AsyncResult;
import android.content.Context;
import android.telephony.Rlog;
import android.os.SystemService;

public class VegaRIL extends RIL {
    public VegaRIL(Context context, int preferredNetworkType, int cdmaSubscription, Integer instanceId) {
        this(context, preferredNetworkType, cdmaSubscription);
    }

    public VegaRIL(Context context, int networkMode, int cdmaSubscription) {
        super(context, networkMode, cdmaSubscription, 0);
    }

    @Override
    public void getRadioCapability(Message response) {
        String rafString = mContext.getResources().getString(
            com.android.internal.R.string.config_radio_access_family);
        if (RILJ_LOGD) riljLog("getRadioCapability: returning static radio capability [" + rafString + "]");
        if (response != null) {
            Object ret = makeStaticRadioCapability();
            AsyncResult.forMessage(response, ret, null);
            response.sendToTarget();
        }
    }
}

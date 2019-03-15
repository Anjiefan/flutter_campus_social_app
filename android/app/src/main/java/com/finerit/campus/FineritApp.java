package com.finerit.campus;

import android.util.Log;

import com.avos.avoscloud.AVException;
import com.avos.avoscloud.AVInstallation;
//import com.avos.avoscloud.AVMixPushManager;
import com.avos.avoscloud.AVOSCloud;
import com.avos.avoscloud.PushService;
import com.avos.avoscloud.feedback.FeedbackAgent;
import com.mob.MobSDK;
import com.tencent.bugly.Bugly;
import com.tencent.bugly.crashreport.CrashReport;

import io.flutter.app.FlutterApplication;

import static com.finerit.campus.Constants.LC_CHANNEL;

public class FineritApp extends FlutterApplication {

    private static final String TAG = "FineritApp";

    @Override
    public void onCreate() {
        super.onCreate();
        Bugly.init(getApplicationContext(), "", false);
        PushService.setDefaultChannelId(this, LC_CHANNEL);
        AVOSCloud.initialize(this, "", "");

        AVOSCloud.setLastModifyEnabled(true);
        AVOSCloud.setDebugLogEnabled(true);

        MobSDK.init(this);
    }
}

////
////  PayMentSteamHandler.h
////  Runner
////
////  Created by 蔡景 on 2019/2/23.
////  Copyright © 2019 The Chromium Authors. All rights reserved.
////
//
#import <Flutter/Flutter.h>
#import "AppDelegate.h"


@interface PayMentSteamHandler :NSObject<FlutterStreamHandler>{
    NSString * PAY_MENT_NOTIFICATION;
    FlutterEventSink _eventSink;
    NSString *billno;
    AppDelegate* _boss;
}
- (void) setBoss:(AppDelegate*) boss;

@end



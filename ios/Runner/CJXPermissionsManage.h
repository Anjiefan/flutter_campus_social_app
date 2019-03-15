//
//  CJXPermissionsManage.h
//  Runner
//
//  Created by 蔡景 on 2019/3/3.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>                   //获取相册状态权限
#import <CoreTelephony/CTCellularData.h>    //网络权限
#import <Contacts/Contacts.h>               //通讯录权限
#import <CoreLocation/CoreLocation.h>       //定位权限
#import <CoreBluetooth/CoreBluetooth.h>     //蓝牙权限
#import <Speech/Speech.h>                   //语音识别
#import <UserNotifications/UserNotifications.h> //推送权限
#import <EventKit/EventKit.h>               //日历备忘录
@interface CJXPermissionsManage : NSObject

+ (instancetype)sharedInstance;
/** 是否自动提示 */
@property (nonatomic, getter=isAutoPresent) BOOL autoPresent;

#pragma mark - 相册权限
/** 是否开启相册权限 */
- (void)getPhotoPermissions:(void(^)(BOOL authorized))completion;

#pragma mark - 是否开启所有需要权限
/** 是否开启所有需要权限 */
+ (BOOL) getPermistionsWhetherOpen;

#pragma mark - 相机权限
/** 是否开启相机权限 */
- (void)getCameraPermissions:(void(^)(BOOL authorized))completion;

#pragma mark - 网络权限
/** 首次进入的蜂窝网络权限 */
- (void)getNetworkPermissions:(void(^)(BOOL authorized))completion;

#pragma mark - 通讯录权限
/** 通讯录权限iOS9以后 */
- (void)getAddressBookPermissions:(void(^)(BOOL authorized))completion;

#pragma mark - 定位权限
/** 获取定位权限 */
//是否一直获取 YES:一直获取 NO:使用期间获取
- (void)getAlwaysLocationPermissions:(BOOL)always completion:(void(^)(BOOL authorized))completion;

#pragma mark - 蓝牙权限
/** 蓝牙权限 */
//暂无测试
- (void)getBluetoothPermissions:(void(^)(BOOL authorized))completion;

#pragma mark - 麦克风权限
/** 麦克风权限 */
- (void)getMicrophonePermissions:(void(^)(BOOL authorized))completion;

#pragma mark - 语音识别权限
/** 语音识别权限iOS10以上 */
- (void)getSpeechRecognitionPermissions:(void(^)(BOOL authorized))completion;

#pragma mark - 推送权限
/** 推送iOS10以上 */
- (void)getPushPermissions:(void(^)(BOOL authorized))completion;

#pragma mark - 日历权限
/** 日历权限 */
- (void)getCalendarPermissions:(void(^)(BOOL authorized))completion;

#pragma mark - 提醒事项权限
/** 提醒事项权限 */
- (void)getReminderPermissions:(void(^)(BOOL authorized))completion;

@end

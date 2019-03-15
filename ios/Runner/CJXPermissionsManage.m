//
//  CJXPermissionsManage.m
//  Runner
//
//  Created by 蔡景 on 2019/3/3.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "CJXPermissionsManage.h"

@interface CJXPermissionsManage()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) void (^getLocation)(BOOL authorized);


@end
@implementation CJXPermissionsManage

+ (instancetype)sharedInstance {
    static CJXPermissionsManage *manage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [[CJXPermissionsManage alloc] init];
    });
    return manage;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.autoPresent = NO;
    }
    return self;
}


#pragma mark - 判断是否权限均已开启
+ (BOOL) getPermistionsWhetherOpen{
    
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (setting.types == UIUserNotificationTypeNone) {
        return false;
    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
         return false;
    }
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusNotDetermined) {
       return false;
    } else if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        return false;
    }

    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        return false;
    }
    
    AVAudioSessionRecordPermission permissionStatus = [[AVAudioSession sharedInstance] recordPermission];
    if (permissionStatus == AVAudioSessionRecordPermissionDenied) {
        return false;
    }
    return true;
}
#pragma mark - 相册权限
- (void)getPhotoPermissions:(void (^)(BOOL))completion {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    //首次安装APP，用户还未授权 系统会请求用户授权
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (status == PHAuthorizationStatusAuthorized) {
                    if (completion) {
                        completion(YES);
                    }
                } else {
                    //点击不允许 给用户提示框
                    [self createAlertWithMessage:@"相册"];
                    if (completion) {
                        completion(NO);
                    }
                }
            });
        }];
    } else if (status == PHAuthorizationStatusAuthorized) {
        NSLog(@"%@",[NSThread currentThread]);
        if (completion) {
            completion(YES);
        }
    } else {
        [self createAlertWithMessage:@"相册"];
        if (completion) {
            completion(NO);
        }
    }
}
#pragma mark - 相机权限
- (void)getCameraPermissions:(void (^)(BOOL))completion {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    //用户接受
                    if (completion) {
                        completion(YES);
                    }
                } else {
                    //用户拒绝
                    [self createAlertWithMessage:@"相机"];
                    if (completion) {
                        completion(NO);
                    }
                }
            });
        }];
    } else if (status == AVAuthorizationStatusAuthorized) {
        if (completion) {
            completion(YES);
        }
    } else {
        [self createAlertWithMessage:@"相机"];
        if (completion) {
            completion(NO);
        }
    }
}
#pragma mark - 网络权限
- (void)getNetworkPermissions:(void (^)(BOOL))completion {
    CTCellularData *cellularData = [[CTCellularData alloc] init];
    CTCellularDataRestrictedState authState = cellularData.restrictedState;
    if (authState == kCTCellularDataRestrictedStateUnknown) {
        cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state){
            if (state == kCTCellularDataNotRestricted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(YES);
                    }
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self createAlertWithMessage:@"无线数据"];
                    if (completion) {
                        completion(NO);
                    }
                });
            }
        };
    } else if (authState == kCTCellularDataNotRestricted){
        if (completion) {
            completion(YES);
        }
    } else {
        [self createAlertWithMessage:@"无线数据"];
        if (completion) {
            completion(NO);
        }
    }
}
#pragma mark - 通讯录权限
- (void)getAddressBookPermissions:(void (^)(BOOL))completion {
    CNContactStore * contactStore = [[CNContactStore alloc]init];
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] ;
    if (status== CNAuthorizationStatusNotDetermined) {
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    if (completion) {
                        completion(NO);
                    }
                    return;
                }
                if (granted) {
                    if (completion) {
                        completion(YES);
                    }
                } else {
                    if (completion) {
                        completion(NO);
                    }
                    [self createAlertWithMessage:@"通讯录"];
                }
            });
        }];
    } else  if (status== CNAuthorizationStatusAuthorized){
        if (completion) {
            completion(YES);
        }
    } else {
        if (completion) {
            completion(NO);
        }
        [self createAlertWithMessage:@"通讯录"];
    }
}
#pragma mark - 定位权限
- (void)getAlwaysLocationPermissions:(BOOL)always completion:(void (^)(BOOL))completion {
    //先判断定位服务是否可用
    if (![CLLocationManager locationServicesEnabled]) {
        NSAssert([CLLocationManager locationServicesEnabled], @"Location service enabled failed");
        return;
    }
    BOOL locationEnable = [CLLocationManager locationServicesEnabled];
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!locationEnable || (status < 3 && status > 0)) {
            if (completion) {
                completion(NO);
            }
            [self createAlertWithMessage:@"位置"];
        } else if (status == kCLAuthorizationStatusNotDetermined){
            //获取授权认证
            self.getLocation = completion;
            if (always) {
                [self.locationManager requestAlwaysAuthorization];
            } else {
                [self.locationManager requestWhenInUseAuthorization]; //使用时开启定位
            }
        } else {
            if (always) {
                if (status == kCLAuthorizationStatusAuthorizedAlways) {
                    if (completion) {
                        completion(YES);
                    }
                } else {
                    if (completion) {
                        completion(NO);
                    }
                }
            } else {
                if (completion) {
                    completion(YES);
                }
            }
        }
    });
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        self.getLocation ? self.getLocation(YES) : nil;
    } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse){
        self.getLocation ? self.getLocation(YES) : nil;
    } else if (status == kCLAuthorizationStatusNotDetermined) {
        
    } else {
        self.getLocation ? self.getLocation(NO) : nil;
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
}

#pragma mark - 蓝牙权限
- (void)getBluetoothPermissions:(void(^)(BOOL authorized))completion {
    CBPeripheralManagerAuthorizationStatus authStatus = [CBPeripheralManager authorizationStatus];
    if (authStatus == CBPeripheralManagerAuthorizationStatusNotDetermined) {
        CBCentralManager *cbManager = [[CBCentralManager alloc] init];
        [cbManager scanForPeripheralsWithServices:nil options:nil];
    } else if (authStatus == CBPeripheralManagerAuthorizationStatusAuthorized) {
        if (completion) {
            completion(YES);
        }
    } else {
        completion(NO);
    }
}

#pragma mark - 麦克风权限
- (void)getMicrophonePermissions:(void(^)(BOOL authorized))completion {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    if (completion) {
                        completion(YES);
                    }
                } else {
                    [self createAlertWithMessage:@"麦克风"];
                    if (completion) {
                        completion(NO);
                    }
                }
            });
        }];
        
    } else if(authStatus == AVAuthorizationStatusAuthorized){
        if (completion) {
            completion(YES);
        }
    } else {
        [self createAlertWithMessage:@"麦克风"];
        if (completion) {
            completion(NO);
        }
    }
}

#pragma mark - 语音识别权限
- (void)getSpeechRecognitionPermissions:(void(^)(BOOL authorized))completion {
    if (@available(iOS 10.0, *)) {
        SFSpeechRecognizerAuthorizationStatus authStatus = [SFSpeechRecognizer authorizationStatus];
        if (authStatus == SFSpeechRecognizerAuthorizationStatusNotDetermined) {
            [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (status == SFSpeechRecognizerAuthorizationStatusAuthorized) {
                        if (completion) {
                            completion(YES);
                        }
                    } else {
                        [self createAlertWithMessage:@"语音识别"];
                        if (completion) {
                            completion(NO);
                        }
                    }
                });
            }];
        } else if (authStatus == SFSpeechRecognizerAuthorizationStatusAuthorized){
            if (completion) {
                completion(YES);
            }
        } else {
            [self createAlertWithMessage:@"语音识别"];
            if (completion) {
                completion(NO);
            }
        }
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark - 推送权限
/** 推送iOS10以上 */
- (void)getPushPermissions:(void(^)(BOOL authorized))completion {
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay completionHandler:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    if (completion) {
                        completion(YES);
                    }
                } else {
                    if (completion) {
                        completion(NO);
                    }
                    [self createAlertWithMessage:@"通知"];
                }
            });
        }];
    } else {
        // Fallback on earlier versions
    }
}
#pragma mark - 日历权限
/** 日历权限 */
- (void)getCalendarPermissions:(void(^)(BOOL authorized))completion {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                if (completion) {
                    completion(YES);
                }
            } else {
                if (completion) {
                    completion(NO);
                }
                [self createAlertWithMessage:@"日历"];
            }
        });
    }];
}
#pragma mark - 提醒事项权限
/** 提醒事项权限 */
- (void)getReminderPermissions:(void(^)(BOOL authorized))completion {
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                if (completion) {
                    completion(YES);
                }
            } else {
                if (completion) {
                    completion(NO);
                }
                [self createAlertWithMessage:@"提醒事项"];
            }
        });
    }];
}
#pragma mark - 弹出提示框
- (void)createAlertWithMessage:(NSString *)message {
    if (!self.autoPresent) {
        return;
    }
    NSString *alertMsg = [NSString stringWithFormat:@"您可以进入系统\"设置>隐私>%@\",允许访问您的%@",message,message];
    NSString *titleMsg = [NSString stringWithFormat:@"%@权限未开启",message];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titleMsg message:alertMsg preferredStyle:UIAlertControllerStyleAlert ];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    UIAlertAction *ensureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertController addAction:ensureAction];
    UIViewController *topVC = [self topViewController];
    dispatch_async(dispatch_get_main_queue(), ^{
        [topVC presentViewController:alertController animated:YES completion:nil];
    });
}
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}
- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
@end

#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import <Flutter/Flutter.h>
#import "BeeCloud.h"
#import <UserNotifications/UserNotifications.h>
#import <AVOSCloud/AVOSCloud.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "WXApi.h"
#import <Bugly/Bugly.h>
#import "CJXPermissionsManage.h"
#import <LeanCloudFeedback/LeanCloudFeedback.h>


@implementation AppDelegate
NSString * CHANNEL_PAYMENT_INVOKE = @"com.finerit.campus/payment/invoke";
NSString * CHANNEL_PAYMENT_CONFIRM = @"com.finerit.campus/payment/confirm";
NSString * CHANNEL_PUSH_CONFIRM = @"com.finerit.campus/push/confirm";
NSString * CHANNEL_PUSH_REGISTER = @"com.finerit.campus/push/register";
NSString * CHANNEL_PUSH_INITIALIZE = @"com.finerit.campus/push/initialize";
NSString * PAY_MENT_NOTIFICATION=@"payment";
NSString * ACTION_LC_RECEIVER = @"com.finerit.campus.ACTION_LC_RECEIVER";
//分享
NSString * CHANNEL_SHARE = @"com.finerit.campus/share/invoke";
NSString * QQ_CHANNEL_INVOKE=@"com.finerit.campus/chat/qq";
NSString * WB_CHANNEL_INVOKE=@"com.finerit.campus/chat/wb";
NSString * WX_CHANNEL_INVOKE=@"com.finerit.campus/chat/wx";
//反馈
NSString * FANKUI_CHANAL_NUM=@"com.finerit.campus/fankui/num";
NSString * FANKUI_CHANAL_INVOKE=@"com.finerit.campus/fankui/invoke";
FlutterEventSink _eventSink;
FlutterViewController* controller;
NSString *billno;
FlutterResult _result;
NSString *type=@"reminder";
- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    controller =(FlutterViewController*)self.window.rootViewController;
    [Bugly startWithAppId:@""];
    //配置权限系统
    if([CJXPermissionsManage getPermistionsWhetherOpen]==false){
        type=@"reminder";
        [CJXPermissionsManage sharedInstance].autoPresent = YES;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"友情提示"
                                                            message:@"以下是系统所需要的所有权限，如果不给予授权将会导致应用部分不可用哦～"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
   
    [self initChannel];
    [self initBeecloudPayment];
    [self initShare];
    [AVOSCloud setApplicationId:@"" clientKey:@""];
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if([type isEqual:@"reminder"]){
        [self requestPermisstion];
        type=@"";
    }
    if (buttonIndex == 1) {
        NSLog(@"点击了确定按钮");
        NSString *str =@"weixin://qr/JnXv90fE6hqVrQOU9yA0";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    else {
        NSLog(@"点击了取消按钮");
    }
}

-(void)requestPermisstion{
    
    [[CJXPermissionsManage sharedInstance] getPhotoPermissions:^(BOOL authorized) {
        if (authorized) {
            NSLog(@"获得%@权限",@"相册");
        } else {
            NSLog(@"未获得%@权限",@"相册");
        }
    }];

    [[CJXPermissionsManage sharedInstance] getCameraPermissions:^(BOOL authorized) {
        if (authorized) {
            NSLog(@"获得%@权限",@"相机");
        } else {
            NSLog(@"未获得%@权限",@"相机");
        }
    }];
    [[CJXPermissionsManage sharedInstance] getMicrophonePermissions:^(BOOL authorized) {
        if (authorized) {
            NSLog(@"获得%@权限",@"麦克风");
        } else {
            NSLog(@"未获得%@权限",@"麦克风");
        }
    }];
    
    [[CJXPermissionsManage sharedInstance] getPushPermissions:^(BOOL authorized) {
        if (authorized) {
            NSLog(@"获得%@权限",@"推送");
        } else {
            NSLog(@"未获得%@权限",@"推送");
        }
    }];
    
    [[CJXPermissionsManage sharedInstance] getAlwaysLocationPermissions:true completion:^(BOOL authorized) {
        if (authorized) {
            NSLog(@"获得%@权限",@"推送");
        } else {
            NSLog(@"未获得%@权限",@"推送");
        }
    }];
    
}





- (void) initShare{
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
         //QQ
        [platformsRegister setupQQWithAppId:@"" appkey:@""];
        //微信
        [platformsRegister setupWeChatWithAppId:@"" appSecret:@""];
        //新浪
        [platformsRegister setupSinaWeiboWithAppkey:@"" appSecret:@"" redirectUrl:@"https://app.finerit.com/index.html"];
        
    }];
   
}
- (void) share{

    NSArray* imageArray = @[[UIImage imageNamed:@"logo.png"]];
   
    if (imageArray) {
        
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"云智校，一个专属大学生的社交APP，一边娱乐一边赚钱，还有免费的代网课的自助系统哦～"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"https://app.finerit.com/index.html"]
                                          title:@"云智校APP"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               if(_result!=NULL){
//                                   NSString *type=[NSString stringWithFormat:@"%lu",(unsigned long)platformType];
                                   _result([NSString stringWithFormat:@"%lu",(unsigned long)platformType]);
                                   _result=nil;
                               }
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                              
                               [alert show];
                               _result(@"-1");
                               _result=nil;
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
}
/**
 * 初始化UNUserNotificationCenter
 */
- (void)registerForRemoteNotification {
    // iOS10 兼容
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        // 使用 UNUserNotificationCenter 来管理通知
        UNUserNotificationCenter *uncenter = [UNUserNotificationCenter currentNotificationCenter];
        // 监听回调事件
        [uncenter setDelegate:self];
        //iOS10 使用以下方法注册，才能得到授权
        [uncenter requestAuthorizationWithOptions:(UNAuthorizationOptionAlert+UNAuthorizationOptionBadge+UNAuthorizationOptionSound)
                                completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [[UIApplication sharedApplication] registerForRemoteNotifications];
                                    });
                                    
                                    //TODO:授权状态改变
                                    NSLog(@"%@" , granted ? @"授权成功" : @"授权失败");
                                }];
        // 获取当前的通知授权状态, UNNotificationSettings
        [uncenter getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            NSLog(@"%s\nline:%@\n-----\n%@\n\n", __func__, @(__LINE__), settings);
            /*
             UNAuthorizationStatusNotDetermined : 没有做出选择
             UNAuthorizationStatusDenied : 用户未授权
             UNAuthorizationStatusAuthorized ：用户已授权
             */
            if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
                NSLog(@"未选择");
            } else if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
                NSLog(@"未授权");
            } else if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                NSLog(@"已授权");
            }
        }];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIUserNotificationType types = UIUserNotificationTypeAlert |
        UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        UIRemoteNotificationType types = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
    }
#pragma clang diagnostic pop
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    AVInstallation *currentInstallation = [AVInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
    NSString *_deviceToken=[currentInstallation deviceToken];
    FlutterMethodChannel* pushRegisterEventChannel = [FlutterMethodChannel
                                                  methodChannelWithName:CHANNEL_PUSH_REGISTER
                                                  binaryMessenger:controller];

    [pushRegisterEventChannel invokeMethod:@"updateInstallationId" arguments:_deviceToken];
    
}
//iOS9之后官方推荐用此方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    NSLog(@"options %@", options);
    if (![BeeCloud handleOpenUrl:url]) {
        //handle其他类型的url
    }
    return YES;
}

- (void)initBeecloudPayment{
    [BeeCloud initWithAppID:@"" andAppSecret:@""];
}

- (void)initChannel{
    //分享
    FlutterMethodChannel* shareMethodChannel = [FlutterMethodChannel
                                                  methodChannelWithName:CHANNEL_SHARE
                                                  binaryMessenger:controller];
    [shareMethodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        
        if ([call.method isEqualToString:@"doShare"]) {
            _result=result;
            [self share];
        }
        
    }];
    //qq跳转
    
    FlutterMethodChannel* qqChatMethodChannel = [FlutterMethodChannel
                                                  methodChannelWithName:QQ_CHANNEL_INVOKE
                                                  binaryMessenger:controller];
    [qqChatMethodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"chatqq"]) {
            NSString *qqNum = @"66064540";
            NSString *qqStr=[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qqNum];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:qqStr]];
        }
       

    }];
    //微信公众号跳转
    FlutterMethodChannel* wxChatMethodChannel = [FlutterMethodChannel
                                                 methodChannelWithName:WX_CHANNEL_INVOKE
                                                 binaryMessenger:controller];
    
    [wxChatMethodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"chatwx"]) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"提示信息"
                                  message:@"复制公众号成功，跳转微信搜索关注？"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  otherButtonTitles:@"确定",nil];

            [alert show];
//            [alert release];
            
          
        }

    }];
    //微博跳转
    FlutterMethodChannel* wbChatMethodChannel = [FlutterMethodChannel
                                                 methodChannelWithName:WB_CHANNEL_INVOKE
                                                 binaryMessenger:controller];
    [wbChatMethodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"chatwb"]) {
            NSURL *url = [NSURL URLWithString:@"sinaweibo://userinfo?uid=6838463764"];
            // 如果已经安装了这个应用,就跳转
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
        
        
    }];
    FlutterMethodChannel* payMentMethodChannel = [FlutterMethodChannel
                                                  methodChannelWithName:CHANNEL_PAYMENT_INVOKE
                                                  binaryMessenger:controller];
    [payMentMethodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        
        if ([call.method isEqualToString:@"doAlipay"]) {
            //            [self doAlipay:[[call arguments] getValue:NULL size:0]]
            NSArray *ar=[call arguments];
            NSLog(@"arguments = %@", ar);
            int money=[[ar objectAtIndex:0] intValue];
            [self doAlipay:money];
        }
        
    }];
    
    FlutterEventChannel* payMentEventChannel = [FlutterEventChannel
                                                eventChannelWithName:CHANNEL_PAYMENT_CONFIRM
                                                binaryMessenger:controller];
    [payMentEventChannel setStreamHandler:self];
    
    FlutterEventChannel* pushConfirmEventChannel = [FlutterEventChannel
                                                eventChannelWithName:CHANNEL_PUSH_CONFIRM
                                                binaryMessenger:controller];
    [pushConfirmEventChannel setStreamHandler:self];
    
    FlutterMethodChannel* pushInitalizeMethodChannel = [FlutterMethodChannel
                                                  methodChannelWithName:CHANNEL_PUSH_INITIALIZE
                                                  binaryMessenger:controller];
    [pushInitalizeMethodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"initializeLCPush"]) {
           [self registerForRemoteNotification];
        }
    }];
    FlutterMethodChannel* fankuiMentMethodChannel = [FlutterMethodChannel
                                                        methodChannelWithName:FANKUI_CHANAL_INVOKE
                                                        binaryMessenger:controller];
    [fankuiMentMethodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"fankui"]){
            NSArray *ar=[call arguments];
            NSLog(@"arguments = %@", ar);
            NSString* phone=[ar objectAtIndex:0];
            LCUserFeedbackAgent *agent = [LCUserFeedbackAgent sharedInstance];
            /* title 传 nil 表示将第一条消息作为反馈的标题。 contact 也可以传入 nil，由用户来填写联系方式。*/
            [agent showConversations:controller title:nil contact:phone];
        }
    }];
    
    FlutterMethodChannel* fankuiNumMethodChannel = [FlutterMethodChannel
                                                    methodChannelWithName:FANKUI_CHANAL_NUM
                                                    binaryMessenger:controller];
    [fankuiNumMethodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"fankuinum"]){
            [[LCUserFeedbackAgent sharedInstance] countUnreadFeedbackThreadsWithBlock:^(NSInteger number, NSError *error) {
                if (error) {
                    // 网络出错了，不设置红点
                    result(0);
                } else {

                }
                 result([NSNumber numberWithInt:number]);
            }];
        }
        
    }];
   

}

- (void)doAlipay:(int) money{
    
    [self doPay:PayChannelAliApp andPaymentTitle:@"凡尔币" andMoney:money];
    
}
#pragma mark - 生成订单号
- (NSString *)genBillNo {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    return [formatter stringFromDate:[NSDate date]];
}

- (void)showAlertView:(NSString *)msg {
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)onBeeCloudResp:(BCBaseResp *)resp{
    BCPayResp *tempResp = (BCPayResp *)resp;
    if (tempResp.resultCode == 0) {
        
        //微信、支付宝、银联支付成功
        [self showAlertView:resp.resultMsg];
        //            [[NSNotificationCenter defaultCenter] postNotificationName:PAY_MENT_NOTIFICATION object:@"pay success"];
        
        NSDictionary *dataDic = [NSDictionary dictionaryWithObject:billno forKey:@"billno"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:PAY_MENT_NOTIFICATION object:nil
         userInfo:dataDic];
        
        
    } else {
        
        [self showAlertView:[NSString stringWithFormat:@"%@ : %@",tempResp.resultMsg, tempResp.errDetail]];
        
    }
}

- (void)doPay:(PayChannel)channel andPaymentTitle: (NSString *)billTitle andMoney: (int)money{
    [BeeCloud setBeeCloudDelegate:self];
    billno = [self genBillNo];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value",@"key", nil];
    
    BCPayReq *payReq = [[BCPayReq alloc] init];
   
    NSString *_money = [NSString stringWithFormat:@"%d",money];
    payReq.channel = channel;
    payReq.title = billTitle;
    payReq.totalFee = _money;
    payReq.billNo = billno;
    payReq.scheme = @"payDemo";
    payReq.billTimeOut = 300;
    payReq.viewController = self;
    payReq.cardType = 0;
    payReq.optional = dict;
 
    [BeeCloud sendBCReq:payReq];
}

- (FlutterError*)onListenWithArguments:(id)arguments
                             eventSink:(FlutterEventSink)eventSink {
    _eventSink = eventSink;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paymentAchive:)  name:PAY_MENT_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushAction:)  name:ACTION_LC_RECEIVER object:nil];
    return nil;
}

/*!
 * Required for iOS 7+
 */
//- (void)application:(UIApplication *)application
//didReceiveRemoteNotification:(NSDictionary *)userInfo
//fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))handler {
//    // Create empty photo object
//    NSString *photoId = [userInfo objectForKey:@"p"];
//    AVObject *targetPhoto = [AVObject objectWithoutDataWithClassName:@"Photo"
//                                                            objectId:photoId];
//
    // Fetch photo object
//    [targetPhoto fetchIfNeededInBackgroundWithBlock:^(AVObject *object, NSError *error) {
//        // Show photo view controller
//        if (error) {
//            handler(UIBackgroundFetchResultFailed);
//        } else if ([AVUser currentUser]) {
//
//        } else {
//            handler(UIBackgroundFetchResultNoData);
//        }
//    }];
//}

/**
 * Required for iOS10+
 * 在前台收到推送内容, 执行的方法
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary *userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //TODO:处理远程推送内容
                NSLog(@"%@", userInfo);
        [[NSNotificationCenter defaultCenter] postNotificationName:ACTION_LC_RECEIVER object:nil
                                                          userInfo:userInfo];
    }
    // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
    completionHandler(UNNotificationPresentationOptionAlert);
}

/**
 * Required for iOS10+
 * 在后台和启动之前收到推送内容, 点击推送内容后，执行的方法
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)())completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //TODO:处理远程推送内容
        NSLog(@"%@", userInfo);
        [[NSNotificationCenter defaultCenter] postNotificationName:ACTION_LC_RECEIVER object:nil
                                                          userInfo:userInfo];
    }
    completionHandler();
}

- (void)pushAction:(NSNotification*)notification{
    NSDictionary *dic=[notification userInfo];
    
    NSString *type = [dic valueForKey:@"type"];//推送消息类型
    NSString *title = [dic valueForKey:@"title"];//推送消息标题
    NSString *content = [dic valueForKey:@"content"];//推送消息内容
    NSString *createTime = [dic valueForKey:@"createTime"];//推送消息内容
    NSString *action = [dic valueForKey:@"action"];//推送消息action
    NSString *sender = [dic valueForKey:@"sender"];//推送消息发送者
    NSArray *values=[NSArray arrayWithObjects:type,title,content,createTime,action,sender,nil];
    values=[values arrayByAddingObject:type];
    values=[values arrayByAddingObject:title];
    values=[values arrayByAddingObject:content];
    values=[values arrayByAddingObject:createTime];
    values=[values arrayByAddingObject:action];
    values=[values arrayByAddingObject:sender];
    if (!_eventSink) return;
    _eventSink(values);
}
- (void)paymentAchive:(NSNotification*)notification{
    NSDictionary *dic=[notification userInfo];
    NSString *billno = [dic objectForKey:@"billno"];
    if (!_eventSink) return;
    _eventSink(billno);
}

- (FlutterError*)onCancelWithArguments:(id)arguments {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _eventSink = nil;
    billno=nil;
    return nil;
}
@end

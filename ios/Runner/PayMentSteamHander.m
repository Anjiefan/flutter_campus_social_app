//
//  PayMentSteamHandler.m
//  Runner
//
//  Created by 蔡景 on 2019/2/23.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "PayMentSteamHander.h"
#include "GeneratedPluginRegistrant.h"
#import "BeeCloud.h"
#import <UserNotifications/UserNotifications.h>
#import <AVOSCloud/AVOSCloud.h>
@implementation PayMentSteamHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        PAY_MENT_NOTIFICATION=@"payment";
    }
    return self;
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
    [BeeCloud initWithAppID:@"0e3cb8f2-e74e-4a85-925f-56499bffaccd" andAppSecret:@"4108118c-db1e-41d3-9265-e4f98ad2592d"];
}

- (void)doAlipay:(int) money{
    
    [self doPay:PayChannelAliApp andPaymentTitle:@"凡尔币充值" andMoney:money];
    
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
        //支付取消或者支付失败
        [self showAlertView:[NSString stringWithFormat:@"%@ : %@",tempResp.resultMsg, tempResp.errDetail]];
        
    }
}
#pragma mark - 微信、支付宝、银联、百度钱包
- (void)doPay:(PayChannel)channel andPaymentTitle: (NSString *)billTitle andMoney: (int)money{
    [BeeCloud setBeeCloudDelegate:_boss];
    billno = [self genBillNo];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value",@"key", nil];
    /**
     按住键盘上的option键，点击参数名称，可以查看参数说明
     **/
    BCPayReq *payReq = [[BCPayReq alloc] init];
    /**
     *  支付渠道，PayChannelWxApp,PayChannelAliApp,PayChannelUnApp,PayChannelBaiduApp
     */
    NSString *_money = [NSString stringWithFormat:@"%d",money];
    payReq.channel = channel; //支付渠道
    payReq.title = billTitle;//订单标题
    payReq.totalFee = _money;//订单价格; channel为BC_APP的时候最小值为100，即1元
    payReq.billNo = billno;//商户自定义订单号
    payReq.scheme = @"payDemo";//URL Scheme,在Info.plist中配置; 支付宝,银联必有参数
    payReq.billTimeOut = 300;//订单超时时间
    payReq.viewController = _boss; //银联支付和Sandbox环境必填
    payReq.cardType = 0; //0 表示不区分卡类型；1 表示只支持借记卡；2 表示支持信用卡；默认为0
    payReq.optional = dict;//商户业务扩展参数，会在webhook回调时返回
    //    [[BeeCloud init] send]
    [BeeCloud sendBCReq:payReq];
}
- (void)setBoss:(AppDelegate *)boss{
    _boss=boss;
}
- (FlutterError*)onListenWithArguments:(id)arguments
                             eventSink:(FlutterEventSink)eventSink {
    _eventSink = eventSink;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paymentAchive:)  name:PAY_MENT_NOTIFICATION object:nil];
    return nil;
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

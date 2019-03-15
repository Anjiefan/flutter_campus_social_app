//
//  MOBFApiService.h
//  MOBFoundation
//
//  Created by 冯鸿杰 on 2017/8/24.
//  Copyright © 2017年 MOB. All rights reserved.
//

#import <MOBFoundation/MOBFoundation.h>

/**
 *  API返回事件
 *
 *  @param responder     回复对象
 */
typedef void(^MOBFApiResultEvent) (NSDictionary *responder);

/**
 *  API错误事件
 *
 *  @param error 错误信息
 */
typedef void(^MOBFApiFaultEvent) (NSError *error);

/**
 接口请求服务
 */
@interface MOBFApiService : MOBFHttpService

/**
 发送接口请求

 @param urlString 请求地址
 @param data 请求数据，一个JSON对象
 @param headers 请求头
 @param timeout 超时时间
 @param rsaKeySize RSA密钥长度
 @param rsaPublicKey RSA公钥
 @param rsaModulus RSA模数
 @param compressData 是否需要压缩数据
 @param resultHandler 返回回调
 @param faultHandler 失败回调
 @return 请求服务对象
 */
+ (MOBFApiService *)sendRequestByURLString:(NSString *)urlString
                                      data:(NSDictionary *)data
                                   headers:(NSDictionary *)headers
                                   timeout:(NSTimeInterval)timeout
                                rsaKeySize:(int)rsaKeySize
                              rsaPublicKey:(NSString *)rsaPublicKey
                                rsaModulus:(NSString *)rsaModulus
                              compressData:(BOOL)compressData
                                  onResult:(MOBFApiResultEvent)resultHandler
                                   onFault:(MOBFApiFaultEvent)faultHandler;

@end

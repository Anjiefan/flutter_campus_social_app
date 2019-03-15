//
//  MOBFBaseService.h
//  MOBFoundation
//
//  Created by fenghj on 15/10/28.
//  Copyright © 2015年 MOB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>

/**
 *  MOB基础服务
 */
@interface MOBFBaseService : NSObject

/**
 *  设置产品标识
 *
 *  @param productId 产品标识
 *  @param version  产品版本
 */
+ (void)setProductId:(NSString *)productId version:(NSInteger)version;

/**
 *  必须使用带有IDFA的框架，此方法用于使依赖的上层框架必须使用带有IDFA的基础库，否则会由于没有该方法而导致编译报错。
 *  上层框架初始化时调用一次即可。
 */
+ (void)mustBeUsedFrameworkWithIdfa;

/**
 用户标识信息，用于请求时带给服务器，该信息包含应用相关信息以及SDK相关信息,格式如下：
 [APPPKG]/[APPVER] ([SDK_TYPE]/[SDK_VERSION])+ [SYSTEM_NAME]/[SYSTEM_VERSION] [TIME_ZONE] Lang/[LANG]

 @return 用户标识信息
 */
+ (NSString *)userIdentity;

/**
 设置域名前缀

 @param domainPrefix 域名前缀
 */
+ (void)setDomainPrefix:(NSString *)domainPrefix;

/**
 *  获取设备唯一标识
 *
 *  @param appKey  应用标识
 *  @param product 产品标识
 *  @param handler 回调处理器
 */
+ (void)getDUIDWithAppKey:(NSString *)appKey
                  product:(NSString *)product
                   result:(void(^)(NSString *duid))handler __deprecated_msg("use [getDUIDWithAppKey:product:sdkVer:result] method instead.");


/**
 *  获取设备唯一标识
 *
 *  @param appKey  应用标识
 *  @param product 产品标识
 *  @param sdkVer  SDK版本
 *  @param handler 回调处理器
 */
+ (void)getDUIDWithAppKey:(NSString *)appKey
                  product:(NSString *)product
                   sdkVer:(NSInteger)sdkVer
                   result:(void(^)(NSString *duid))handler __deprecated_msg("use [startupWithAppKey:product:sdkVer:result] method instead.");

/**
 *  启动服务
 *
 *  @param appKey  应用标识
 *  @param product 产品标识
 *  @param sdkVer  SDK版本
 *  @param handler 回调处理器
 */
+ (void)startupWithAppKey:(NSString *)appKey
                  product:(NSString *)product
                   sdkVer:(NSInteger)sdkVer
                   result:(void(^)(NSString *duid))handler;


/**
 获取设备ID

 @param handler 回调处理器
 */
+ (void)getDuid:(void(^)(NSString *duid))handler;

@end

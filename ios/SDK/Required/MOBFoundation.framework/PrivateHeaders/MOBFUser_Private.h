//
//  MOBFUser_Private.h
//  MOBFoundation
//
//  Created by 冯鸿杰 on 17/3/17.
//  Copyright © 2017年 MOB. All rights reserved.
//

#ifdef MOBFPriateHeader

#import "MOBFUser.h"

#else

#import <MOBFoundation/MOBFUser.h>

#endif

@interface MOBFUser ()

/**
 用户标识
 */
@property (nonatomic, copy, nullable) NSString * uid;

/**
 应用的用户标识
 */
@property (nonatomic, copy, nullable) NSString * appUid;

/**
 过期时间
 */
@property (nonatomic) NSTimeInterval expiredAt;

/**
 是否为第三方用户
 */
@property (nonatomic) BOOL isFromThirdParty;

/**
 是否为匿名用户
 */
@property (nonatomic) BOOL isAnonymous;

/**
 是否修改过信息
 */
@property (nonatomic) BOOL isModify;

/**
 创建匿名用户信息
 
 @return 用户信息
 */
+ (MOBFUser * _Nonnull)anonymousUser;

@end

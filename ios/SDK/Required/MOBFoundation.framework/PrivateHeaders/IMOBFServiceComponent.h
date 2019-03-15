//
//  IMOBFServiceComponent.h
//  MOBFoundation
//
//  Created by 冯鸿杰 on 17/2/15.
//  Copyright © 2017年 MOB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMOBFComponent.h"

/**
 服务组件
 */
@protocol IMOBFServiceComponent <IMOBFComponent>

@required

/**
 获取组件名称

 @return 组件名称
 */
+ (NSString *)componentName;

/**
 获取组件版本号

 @return 组件版本号
 */
+ (NSString *)componentVersion;

@optional

/**
 获取组件名称
 
 @return 组件名称
 */
+ (NSString *)name;

/**
 获取组件版本号
 
 @return 组件版本号
 */
+ (NSString *)version;

/**
 组件注册时触发
 
 @param duid 设备ID
 */
+ (void)onReg:(NSString *)duid;

@end

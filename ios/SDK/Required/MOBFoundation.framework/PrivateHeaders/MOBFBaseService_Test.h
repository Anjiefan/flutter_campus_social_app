//
//  MOBFBaseService_Test.h
//  MOBFoundation
//
//  Created by liyc on 2018/3/12.
//  Copyright © 2018年 MOB. All rights reserved.
//

#import "MOBFBaseService.h"

@interface MOBFBaseService ()

#pragma mark - test
/**
 控制统计功能开关

 @param key 统计功能key
 @param state 开关状态
 */
+ (void)controlSwitch:(NSString *)key state:(NSInteger)state;

/**
 写日志
 
 @param data 数据
 */
+ (void)writeLog:(id)data;

/**
 清空缓存
 */
+ (void)clearCache:(NSString *)domain;

#pragma mark - 日志上传授权
+ (void)requestLogAuth:(void (^)())logHandler;

@end

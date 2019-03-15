//
//  IMOBFComponent.h
//  MOBFoundation
//
//  Created by 冯鸿杰 on 17/2/14.
//  Copyright © 2017年 MOB. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 组件协议
 */
@protocol IMOBFComponent <NSObject>

@optional

/**
 初始化组件时触发
 */
+ (void)onInit;

@end

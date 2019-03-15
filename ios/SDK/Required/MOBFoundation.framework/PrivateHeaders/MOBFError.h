//
//  MOBFError.h
//  MOBFoundation
//
//  Created by 冯鸿杰 on 17/3/1.
//  Copyright © 2017年 MOB. All rights reserved.
//

#ifndef MOBFError_h
#define MOBFError_h

#include <stdio.h>

#pragma mark - 错误码

/**
 *  接口格式返回不正确
 */
extern const int MOBFErrorCodeResponseDataIncorrect;

/**
 *  HTTP请求失败
 */
extern const int MOBFErrorCodeHTTPRequestFail;

/**
 *  业务接口请求失败
 */
extern const int MOBFErrorCodeApiRequestFail;

/**
 *  请求超时
 */
extern const int MOBFErrorCodeRequestTimeout;

/**
 *  无效参数
 */
extern const int MOBFErrorCodeInvalidParameter;

#endif /* MOBFError_h */

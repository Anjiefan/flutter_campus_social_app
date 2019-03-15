//
//  MOBFUploadedImage.h
//  MOBFoundation
//
//  Created by 冯鸿杰 on 2017/5/10.
//  Copyright © 2017年 MOB. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 上传文件
 */
@interface MOBFUploadedFile : NSObject

/**
 源文件路径
 */
@property (nonatomic, copy, readonly) NSString *source;


/**
 初始化

 @param dict 服务器数据
 @return 上传文件对象
 */
- (instancetype)initWithDict:(NSDictionary *)dict;

@end

//
//  MOBFUploadedImage.h
//  MOBFoundation
//
//  Created by 冯鸿杰 on 2017/5/10.
//  Copyright © 2017年 MOB. All rights reserved.
//

#import "MOBFUploadedFile.h"

/**
 已上传的图片
 */
@interface MOBFUploadedImage : MOBFUploadedFile

/**
 拉伸图片集合
 */
@property (nonatomic, strong, readonly) NSDictionary* scaleImages;

/**
 生成的原始图片地址
 */
@property (nonatomic, copy, readonly) NSString *srcImageURL;

@end

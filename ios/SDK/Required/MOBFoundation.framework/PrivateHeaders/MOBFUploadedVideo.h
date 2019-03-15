//
//  MOBFUploadedVideo.h
//  MOBFoundation
//
//  Created by 冯鸿杰 on 2017/5/10.
//  Copyright © 2017年 MOB. All rights reserved.
//

#import "MOBFUploadedFile.h"

/**
 已上传的视频信息
 */
@interface MOBFUploadedVideo : MOBFUploadedFile

/**
 视频时长
 */
@property (nonatomic, readonly) NSTimeInterval duration;

@end

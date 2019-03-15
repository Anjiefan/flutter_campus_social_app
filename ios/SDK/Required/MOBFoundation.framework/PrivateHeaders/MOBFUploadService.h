//
//  MOBFUploadService.h
//  MOBFoundation
//
//  Created by 冯鸿杰 on 2017/5/10.
//  Copyright © 2017年 MOB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOBFUploadedFile.h"
#import "MOBFUploadedImage.h"
#import "MOBFUploadedVideo.h"

/**
 上传文件存储类型

 - MOBFUploadFileStoredTypeDefault: 默认类型，不重复存储文件
 - MOBFUploadFileStoredTypeOverwrite: 覆盖存储文件
 */
typedef NS_ENUM(NSUInteger, MOBFUploadFileStoredType)
{
    MOBFUploadFileStoredTypeDefault = 1,
    MOBFUploadFileStoredTypeOverwrite = 2,
};

/**
 上传服务
 */
@interface MOBFUploadService : NSObject


/**
 初始化

 @param component 组件对象，传入实现IMOBFServiceComponent的对象类型
 @param baseUrl 基础服务路径
 @return 服务对象
 */
- (instancetype)initWithComponent:(id)component
                          BaseUrl:(NSURL *)baseUrl;


/**
 上传图片

 @param path 图片路径
 @param storedType 存储类型
 @param scales 缩放规格，如：[@100, @200, @300]
 @param resultHandler 返回回调
 */
- (void)uploadImageWithPath:(NSString *)path
                 storedType:(MOBFUploadFileStoredType)storedType
                     scales:(NSArray *)scales
                   onResult:(void (^)(MOBFUploadedImage *image, NSError *error))resultHandler;

/**
 上传头像

 @param path 图片路径
 @param storedType 存储类型
 @param scales 缩放规格，如：[@100, @200, @300]
 @param resultHandler 返回回调
 */
- (void)uploadAvatarWithPath:(NSString *)path
                  storedType:(MOBFUploadFileStoredType)storedType
                      scales:(NSArray *)scales
                    onResult:(void (^)(MOBFUploadedImage *image, NSError *error))resultHandler;

/**
 上传文件

 @param path 文件路径
 @param storedType 存储类型
 @param resultHandler 返回回调
 */
- (void)uploadFileWithPath:(NSString *)path
                storedType:(MOBFUploadFileStoredType)storedType
                  onResult:(void (^)(MOBFUploadedFile *file, NSError *error))resultHandler;


/**
 上传视频

 @param path 视频路径
 @param storedType 存储类型
 @param resultHandler 返回回调
 */
- (void)uploadVideoWithPath:(NSString *)path
                 storedType:(MOBFUploadFileStoredType)storedType
                   onResult:(void (^)(MOBFUploadedVideo *video, NSError *error))resultHandler;

@end

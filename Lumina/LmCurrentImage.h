//
//  RnCurrentImage.h
//  Renoir
//
//  Created by SSC on 2014/05/17.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LmCurrentImage : NSObject

@property (nonatomic, assign) CGSize originalImageSize;
@property (nonatomic, strong) NSMutableDictionary* cache;

+ (LmCurrentImage*)instance;
+ (BOOL)imageExistsAtPath:(NSString*)path;
+ (UIImage*)imageAtPath:(NSString*)path;
+ (BOOL)saveImage:(UIImage*)image AtPath:(NSString*)path;
+ (BOOL)writeImage:(UIImage*)image AtPath:(NSString*)path;
+ (BOOL)deleteImageAtPath:(NSString*)path;
+ (void)writeCacheToFile;
+ (void)cleanCache;
+ (void)clean;

+ (BOOL)saveTmpImage:(UIImage*)image;
+ (BOOL)writeTmpImage:(UIImage*)image;
+ (UIImage*)tmpImage;

@end

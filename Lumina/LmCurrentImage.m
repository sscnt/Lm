//
//  RnCurrentImage.m
//  Renoir
//
//  Created by SSC on 2014/05/17.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCurrentImage.h"

@implementation LmCurrentImage

#pragma mark init

static LmCurrentImage* sharedRnCurrentImage = nil;

NSString* const pathForOriginalImage = @"tmp/original_image";
NSString* const pathForPreviewOriginalImage = @"tmp/preview_original_image";
NSString* const pathForTmpImage = @"tmp/tmp_image";

+ (LmCurrentImage*)instance {
	@synchronized(self) {
		if (sharedRnCurrentImage == nil) {
			sharedRnCurrentImage = [[self alloc] init];
		}
	}
	return sharedRnCurrentImage;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedRnCurrentImage == nil) {
			sharedRnCurrentImage = [super allocWithZone:zone];
			return sharedRnCurrentImage;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}

- (id)init
{
    self = [super init];
    if (self) {
        _cache = [NSMutableDictionary dictionary];        
    }
    return self;
}

#pragma mark util

+ (UIImage*)imageAtPath:(NSString *)path
{
    //// Search cache
    UIImage* image = [[self instance].cache objectForKey:[NSString stringWithFormat:@"%@", path]];
    if (image) {
        return image;
    }

    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:path];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if( [filemgr fileExistsAtPath:filePath] ){
        UIImage *img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:fileURL]];
        return img;
    }
    
    LOG(@"Image not found at %@.", path);
    
    return nil;
}

+ (BOOL)saveImage:(UIImage *)image AtPath:(NSString *)path
{
    if (image.imageOrientation != UIImageOrientationUp) {
        image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationUp];
    }
    if (image) {
        [[self instance].cache removeObjectForKey:[NSString stringWithFormat:@"%@", path]];
        [[self instance].cache setObject:image forKey:[NSString stringWithFormat:@"%@", path]];
    }
    return YES;
}

+ (BOOL)writeImage:(UIImage *)image AtPath:(NSString *)path
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.99);
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:path];
    BOOL success = [imageData writeToFile:filePath atomically:YES];
    imageData = nil;
    return success;
}

+ (BOOL)deleteImageAtPath:(NSString *)path
{
    [[self instance].cache removeObjectForKey:path];
    
    path = [NSHomeDirectory() stringByAppendingPathComponent:path];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSURL *pathurl = [NSURL fileURLWithPath:path];
    if( [filemgr fileExistsAtPath:path] ){
        LOG(@"deleting the image at %@" ,path);
        return [filemgr removeItemAtURL:pathurl error:nil];
    }
    return YES;
}

+ (BOOL)imageExistsAtPath:(NSString *)path
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:path];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if( [filemgr fileExistsAtPath:filePath] ){
        return YES;
    }
    return NO;
}

+ (void)writeCacheToFile
{
    for (NSString* path in [[self instance].cache allKeys]) {
        [self writeImage:[[self instance].cache objectForKey:path] AtPath:path];
    }
}

+ (void)cleanCache
{
    [[self instance].cache removeAllObjects];
}

#pragma mark api

+ (BOOL)saveTmpImage:(UIImage *)image
{
    return [self saveImage:image AtPath:pathForPreviewOriginalImage];
}

+ (BOOL)writeTmpImage:(UIImage *)image
{
    return [self writeImage:image AtPath:pathForTmpImage];
}

+ (UIImage *)tmpImage
{
    return [self imageAtPath:pathForTmpImage];
}

+ (void)clean
{
    [self cleanCache];
}

@end

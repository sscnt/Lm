//
//  LmObjectPixelData.h
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LmObjectPixelData : NSObject

@property (nonatomic, assign) size_t bufferSize;
@property (nonatomic, assign) size_t bytesPerRow;
@property (nonatomic, assign) size_t width;
@property (nonatomic, assign) size_t height;
@property (nonatomic, assign) UIDeviceOrientation orientation;
@property (nonatomic, strong) NSData* pixelData;

@end

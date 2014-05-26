//
//  LmCmImageAsset.h
//  Lumina
//
//  Created by SSC on 2014/05/26.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LmCmImageAsset : NSObject

@property (nonatomic, assign) UIDeviceOrientation orientation;
@property (nonatomic, assign) float zoom;
@property (nonatomic, assign) LmCmViewCropSize cropSize;
@property (nonatomic, strong) UIImage* image;
@property (nonatomic, assign) BOOL frontCamera;

@end

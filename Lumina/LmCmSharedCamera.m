//
//  LmCurrentCamera.m
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmSharedCamera.h"

@implementation LmCmSharedCamera

static LmCmSharedCamera* sharedLmCurrentCamera = nil;

+ (LmCmSharedCamera*)instance {
	@synchronized(self) {
		if (sharedLmCurrentCamera == nil) {
			sharedLmCurrentCamera = [[self alloc] init];
		}
	}
	return sharedLmCurrentCamera;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedLmCurrentCamera == nil) {
			sharedLmCurrentCamera = [super allocWithZone:zone];
			return sharedLmCurrentCamera;
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
        [self reset];
    }
    return self;
}

+ (void)reset
{
    LmCmSharedCamera* _self = [self instance];
    _self.focusMode = LmCmSharedCameraFocusModeAuto;
    _self.mode = LmCmSharedCameraModeNormal;
    [[LmCmSharedCamera instance] reset];
}

- (void)reset
{
    _zoom = 1.0f;
}

#pragma mark settings


+ (float)topBarHeight
{
    return 50.0f;
}

+ (float)bottomBarHeight
{
    return 88.0f;
}

+ (CGRect)shutterButtonRect
{
    return CGRectMake(0.0f, 0.0f, 70.0f, 70.0f);
}

+ (UIColor *)topBarColor
{
    return [UIColor colorWithWhite:0.10f alpha:1.0f];
}

+ (UIColor *)bottomBarColor
{
    return [self topBarColor];
}

+ (BOOL)showGrid
{
    return YES;
}

#pragma mark api
#pragma mark zoom

+ (void)setZoom:(float)zoom
{
    [self instance].zoom = zoom;
}

+ (float)maxZoomScaleSupported
{
    return 9.0f;
}

+ (UIColor *)zoomSliderBgColor
{
    return [UIColor colorWithWhite:0.10f alpha:0.50f];
}

@end

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
    return CGRectMake(0.0f, 0.0f, 66.0f, 66.0f);
}

+ (UIColor *)topBarColor
{
    return [UIColor colorWithWhite:0.10f alpha:1.0f];
}

+ (UIColor *)bottomBarColor
{
    return [self topBarColor];
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

#pragma mark settings

+ (UIColor *)settingsBgColor
{
    return [UIColor colorWithWhite:0.10f alpha:0.90f];
}

//// 2 is YES, 1 is NO, 0 is Nil
- (BOOL)showGrid
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    int show = (int)[ud integerForKey:@"showGrid"];
    if (show == 2) {
        return YES;
    }
    if (show == 1) {
        return NO;
    }
    self.showGrid = YES;
    return YES;
}

- (void)setShowGrid:(BOOL)showGrid
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (showGrid) {
        [ud setInteger:2 forKey:@"showGrid"];
    }else{
        [ud setInteger:1 forKey:@"showGrid"];
    }
    [ud synchronize];
}

- (BOOL)showZoomSlider
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    int show = (int)[ud integerForKey:@"showZoomSlider"];
    if (show == 2) {
        return YES;
    }
    if (show == 1) {
        return NO;
    }
    self.showZoomSlider = YES;
    return YES;
}

- (void)setShowZoomSlider:(BOOL)showZoomSlider
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (showZoomSlider) {
        [ud setInteger:2 forKey:@"showZoomSlider"];
    }else{
        [ud setInteger:1 forKey:@"showZoomSlider"];
    }
    [ud synchronize];
}

- (BOOL)soundEnabled
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    int show = (int)[ud integerForKey:@"soundEnabled"];
    if (show == 2) {
        return YES;
    }
    if (show == 1) {
        return NO;
    }
    self.showZoomSlider = YES;
    return YES;
}

- (void)setSoundEnabled:(BOOL)soundEnabled
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (soundEnabled) {
        [ud setInteger:2 forKey:@"soundEnabled"];
    }else{
        [ud setInteger:1 forKey:@"soundEnabled"];
    }
    [ud synchronize];
}


- (BOOL)volumeSnapEnabled
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    int show = (int)[ud integerForKey:@"volumeSnapEnabled"];
    if (show == 2) {
        return YES;
    }
    if (show == 1) {
        return NO;
    }
    self.showZoomSlider = YES;
    return YES;
}

- (void)setVolumeSnapEnabled:(BOOL)volumeSnapEnabled
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (volumeSnapEnabled) {
        [ud setInteger:2 forKey:@"volumeSnapEnabled"];
    }else{
        [ud setInteger:1 forKey:@"volumeSnapEnabled"];
    }
    [ud synchronize];
}


- (LmCmViewCropSize)cropSize
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    int size = (int)[ud integerForKey:@"cropSize"];
    if (size == 0) {
        self.cropSize = LmCmViewCropSizeNormal;
        return LmCmViewCropSizeNormal;
    }
    return size;
}

- (void)setCropSize:(LmCmViewCropSize)cropSize
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:cropSize forKey:@"cropSize"];
    [ud synchronize];
}



@end

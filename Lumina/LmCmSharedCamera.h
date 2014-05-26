//
//  LmCurrentCamera.h
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, LmCmSharedCameraMode){
    LmCmSharedCameraModeNormal = 1,
    LmCmSharedCameraModeBurst,
    LmCmSharedCameraModeX30,
    LmCmSharedCameraModeX60,
    LmCmSharedCameraModeX120
};

typedef NS_ENUM(NSInteger, LmCmSharedCameraFocusMode){
    LmCmSharedCameraFocusModeAuto = 1,
    LmCmSharedCameraFocusModeManual
};

typedef NS_ENUM(NSInteger, LmCmSharedCameraTheme){
    LmCmSharedCameraThemeBlack = 1,
};

typedef NS_ENUM(NSInteger, LmCmViewSettingsListItem){
    LmCmViewSettingsListItemShowGrid = 1,
    LmCmViewSettingsListItemShowZoom,
    LmCmViewSettingsListItemVolumeSnap,
    LmCmViewSettingsListItemEnableSound
};

typedef NS_ENUM(NSInteger, LmCmViewCropSize){
    LmCmViewCropSizeNormal = 1,
    LmCmViewCropSizeSquare,
    LmCmViewCropSize16x9,
    LmCmViewCropSize2x1
};

typedef NS_ENUM(NSInteger, LmCmViewBarButtonFlashMode){
    LmCmViewBarButtonFlashModeAuto = 1,
    LmCmViewBarButtonFlashModeOn,
    LmCmViewBarButtonFlashModeOff
};

@interface LmCmSharedCamera : NSObject

@property (nonatomic, assign) LmCmSharedCameraMode mode;
@property (nonatomic, assign) LmCmSharedCameraFocusMode  focusMode;
@property (nonatomic, assign) LmCmViewBarButtonFlashMode  flashMode;
@property (nonatomic, assign) LmCmViewCropSize cropSize;
@property (nonatomic, assign) int timerSeconds;
@property (nonatomic, assign) float zoom;
@property (nonatomic, assign) BOOL showGrid;
@property (nonatomic, assign) BOOL showZoomSlider;
@property (nonatomic, assign) BOOL volumeSnapEnabled;
@property (nonatomic, assign) BOOL soundEnabled;

+ (LmCmSharedCamera*)instance;

+ (BOOL)isTimerEnabled;
+ (int)timerSeconds;

+ (LmCmSharedCameraMode)currentMode;
+ (void)setMode:(LmCmSharedCameraMode)mode;

+ (void)setZoom:(float)zoom;
+ (float)maxZoomScaleSupported;

#pragma mark settings

+ (float)topBarHeight;
+ (float)bottomBarHeight;
+ (CGRect)shutterButtonRect;
+ (UIColor*)topBarColor;
+ (UIColor*)bottomBarColor;
+ (UIColor*)cropMaskColor;

+ (UIColor*)zoomSliderBgColor;
+ (UIColor*)settingsBgColor;

@end

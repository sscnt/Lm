//
//  LmCurrentCamera.h
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, LmCurrentCameraMode){
    LmCurrentCameraModeNormal = 1,
    LmCurrentCameraModeBurst,
    LmCurrentCameraModeX30,
    LmCurrentCameraModeX60,
    LmCurrentCameraModeX120
};


@interface LmCmSharedCamera : NSObject

@property (nonatomic, assign) LmCurrentCameraMode mode;
@property (nonatomic, assign) int timerSeconds;
@property (nonatomic, assign) float zoom;

+ (LmCmSharedCamera*)instance;

+ (BOOL)isTimerEnabled;
+ (int)timerSeconds;

+ (LmCurrentCameraMode)currentMode;
+ (void)setMode:(LmCurrentCameraMode)mode;

+ (void)setZoom:(float)zoom;
+ (float)maxZoomScaleSupported;

#pragma mark settings

+ (float)topBarHeight;
+ (float)bottomBarHeight;
+ (CGRect)shutterButtonRect;
+ (UIColor*)topBarColor;
+ (UIColor*)bottomBarColor;
+ (BOOL)showGrid;

+ (UIColor*)zoomSliderBgColor;

@end

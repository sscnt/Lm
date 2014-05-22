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


@interface LmCurrentCamera : NSObject

@property (nonatomic, assign) LmCurrentCameraMode mode;
@property (nonatomic, assign) int timerSeconds;

+ (LmCurrentCamera*)instance;

+ (BOOL)isTimerEnabled;
+ (int)timerSeconds;

+ (LmCurrentCameraMode)currentMode;
+ (void)setMode:(LmCurrentCameraMode)mode;

@end

//
//  ViewController.h
//  Lumina
//
//  Created by SSC on 2014/05/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraManager.h"
#import "LmViewCameraPreviewOverlay.h"
#import "LmButtonShutter.h"
#import "LmViewCameraTopBar.h"
#import "LmViewCameraBottomBar.h"

@interface LmViewControllerCamera : UIViewController <CameraManagerDelegate>

@property (nonatomic, strong) CameraManager* cameraManager;
@property (nonatomic, strong) UIView* cameraPreview;
@property (nonatomic, strong) LmViewCameraPreviewOverlay* cameraPreviewOverlay;
@property (nonatomic, strong) LmButtonShutter* shutterButton;
@property (nonatomic, strong) LmViewCameraTopBar* topBar;
@property (nonatomic, strong) LmViewCameraBottomBar* bottomBar;

- (void)didShutterButtonTouchUpInside:(id)sender;

@end

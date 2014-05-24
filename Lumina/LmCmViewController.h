//
//  ViewController.h
//  Lumina
//
//  Created by SSC on 2014/05/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraManager.h"
#import "LmCmViewPreviewOverlay.h"
#import "LmCmButtonShutter.h"
#import "LmCmViewTopBar.h"
#import "LmCmViewBottomBar.h"
#import "LmCmViewManagerZoom.h"
#import "LmCmViewManagerPreview.h"

@interface LmCmViewController : UIViewController <CameraManagerDelegate, UIGestureRecognizerDelegate, LmCmViewManagerZoomDelegate, LmCmViewManagerPreviewDelegate>

@property (nonatomic, strong) CameraManager* cameraManager;
@property (nonatomic, strong) UIView* cameraPreview;
@property (nonatomic, strong) LmCmViewPreviewOverlay* cameraPreviewOverlay;
@property (nonatomic, strong) LmCmButtonShutter* shutterButton;
@property (nonatomic, strong) LmCmViewTopBar* topBar;
@property (nonatomic, strong) LmCmViewBottomBar* bottomBar;

@property (nonatomic, strong) LmCmViewManagerZoom* zoomViewManager;
@property (nonatomic, strong) LmCmViewManagerPreview* previewManager;

- (void)didShutterButtonTouchUpInside:(id)sender;
- (void)didShutterButtonTouchCancel:(id)sender;

@end

//
//  ViewController.h
//  Lumina
//
//  Created by SSC on 2014/05/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import "LmCmCameraManager.h"
#import "LmCmViewPreviewOverlay.h"
#import "LmCmButtonShutter.h"
#import "LmCmViewTopBar.h"
#import "LmCmViewBottomBar.h"
#import "LmCmViewManagerZoom.h"
#import "LmCmViewManagerPreview.h"
#import "LmCmViewManagerTools.h"
#import "LmCmViewCropBlackRect.h"

@interface LmCmViewController : UIViewController <CameraManagerDelegate, UIGestureRecognizerDelegate, LmCmViewManagerZoomDelegate, LmCmViewManagerPreviewDelegate, LmCmViewManagerToolsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
     float initialVolume;
}

@property (nonatomic, strong) LmCmCameraManager* cameraManager;
@property (nonatomic, strong) UIView* cameraPreview;
@property (nonatomic, strong) LmCmViewPreviewOverlay* cameraPreviewOverlay;
@property (nonatomic, strong) LmCmButtonShutter* shutterButton;
@property (nonatomic, strong) LmCmViewTopBar* topBar;
@property (nonatomic, strong) LmCmViewBottomBar* bottomBar;
@property (nonatomic, strong) LmCmViewCropBlackRect* blackRectView;

@property (nonatomic, strong) LmCmViewManagerZoom* zoomViewManager;
@property (nonatomic, strong) LmCmViewManagerPreview* previewManager;
@property (nonatomic, strong) LmCmViewManagerTools* toolsManager;

@property (nonatomic, strong) ALAssetsLibrary* assetLibrary;

- (void)didShutterButtonTouchUpInside:(id)sender;
- (void)didShutterButtonTouchCancel:(id)sender;
- (void)orientationDidChange;
- (void)loadLastPhoto;
- (void)lastAssetDidLoad:(ALAsset*)asset;
- (void)flashScreen;

- (void)initVolumeHandling;

- (void)enableCamera;
- (void)disableCamera;

@end

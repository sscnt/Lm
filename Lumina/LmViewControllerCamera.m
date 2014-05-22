//
//  ViewController.m
//  Lumina
//
//  Created by SSC on 2014/05/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmViewControllerCamera.h"

@interface LmViewControllerCamera ()

@end

@implementation LmViewControllerCamera

- (void)viewDidLoad
{
    [super viewDidLoad];
    //// camera
    _cameraManager = [[CameraManager alloc] init];
    _cameraManager.delegate = self;
    
    //// Preview
    _cameraPreview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, [LmCurrentSettings topBarHeight], [UIScreen width], [UIScreen height] - [LmCurrentSettings topBarHeight] - [LmCurrentSettings bottomBarHeight])];
    [self.view addSubview:_cameraPreview];
    [_cameraManager setPreview:_cameraPreview];
    
    //// Bar
    _topBar = [[LmViewCameraTopBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen width], [LmCurrentSettings topBarHeight])];
    [self.view addSubview:_topBar];
    _bottomBar = [[LmViewCameraBottomBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen width], [LmCurrentSettings bottomBarHeight])];
    [_bottomBar setY:[UIScreen height] - [_bottomBar height]];
    [self.view addSubview:_bottomBar];
    
    //// Shutter
    _shutterButton = [[LmButtonShutter alloc] initWithFrame:[LmCurrentSettings shutterButtonRect]];
    [_shutterButton addTarget:self action:@selector(didShutterButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomBar addShutterButton:_shutterButton];
}

#pragma mark shutter

- (void)didShutterButtonTouchUpInside:(id)sender
{
    [_cameraManager takeAPhoto];
}

#pragma mark delegate

- (void)singleImageCaptured:(UIImage *)image withOrientation:(UIDeviceOrientation)orientation
{
    LOG(@"photo saved.");
    switch (orientation) {
        case UIDeviceOrientationUnknown:
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationLeft];
            break;
        case UIDeviceOrientationPortrait:
            image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationRight];
            break;
        case UIDeviceOrientationLandscapeLeft:
            break;
        case UIDeviceOrientationLandscapeRight:
            image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationDown];
            break;
        default:
            break;
    }
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

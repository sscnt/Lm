//
//  LmCmViewManagerTools.m
//  Lumina
//
//  Created by SSC on 2014/05/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewManagerTools.h"
#import "LmCmViewController.h"

@implementation LmCmViewManagerTools

- (void)viewDidLoad
{
    LmCmViewController* _self = self.delegate;
    LmCmViewBottomBar* bar = _self.bottomBar;
    LmCmViewTopBar* topBar = _self.topBar;
    
    //// Settings
    _settingsButton = [[LmCmViewBarButton alloc] initWithType:LmCmViewBarButtonTypeSettings];
    [_settingsButton addTarget:self action:@selector(settingsButtonDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [bar addSettingsButton:_settingsButton];
    
    //// Camera Roll
    _camerarollButton = [[LmCmViewBarButton alloc] initWithType:LmCmViewBarButtonTypeCameraRoll];
    [_camerarollButton addTarget:self action:@selector(camerarollButtonDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [bar addCamerarollButton:_camerarollButton];
    
    //// Crop
    _cropButton = [[LmCmViewBarButton alloc] initWithType:LmCmViewBarButtonTypeCrop];
    [_cropButton addTarget:self action:@selector(cropButtonDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [bar addCropButton:_cropButton];
    
    //// Settings & Crop
    {
        float width = 240.0f;
        float right = [_self.zoomViewManager.zoomSlider width];
        float x = [_self.cameraPreviewOverlay width] - width - right;
        float height = 44.0f * 2.0f + 5.0f;
        float y = [_self.cameraPreviewOverlay height] - height + 5.0f;
        _settingsList = [[LmCmViewSettingsList alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _settingsList.hidden = YES;
        _settingsList.delegate = self;
        [_self.cameraPreviewOverlay addSubview:_settingsList];
        
        _cropList = [[LmCmViewCropList alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _cropList.hidden = YES;
        _cropList.delegate = self;
        [_cropList setCurrentSize:[LmCmSharedCamera instance].cropSize];
        [_self.cameraPreviewOverlay addSubview:_cropList];
    }
    
    
    //// Switch
    _switchCameraButton = [[LmCmViewBarButton alloc] initWithType:LmCmViewBarButtonTypeSwitchCamera];
    [_switchCameraButton addTarget:self action:@selector(cameraSwitchButtonDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [topBar addCameraSwitchButton:_switchCameraButton];
    
    //// Flash Button
    _flashButton = [[LmCmViewBarButton alloc] initWithType:LmCmViewBarButtonTypeFlash];
    _flashButton.flashMode = [LmCmSharedCamera instance].flashMode;
    [_flashButton addTarget:self action:@selector(flashButtonDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    if ([LmCmSharedCamera instance].soundEnabled == NO) {
        _flashButton.hidden = YES;
    }
    [topBar addFlashButton:_flashButton];
    
    //// Flash
    {
        float width = [_flashButton width] - 4.0f;
        float height = [LmCmSharedCamera topBarHeight] * 2.0f;
        _flashList = [[LmCmViewFlashModeList alloc] initWithFrame:CGRectMake(2.0f, 0.0f, width, height)];
        _flashList.hidden = YES;
        _flashList.delegate = self;
        _flashList.currentMode = [LmCmSharedCamera instance].flashMode;
        [_self.cameraPreviewOverlay addSubview:_flashList];
    }
}

#pragma mark button

- (void)settingsButtonDidTouchUpInside:(LmCmViewBarButton *)sender
{
    _settingsList.hidden = sender.selected;
    sender.selected = !sender.selected;
    
    //// Hide Crop
    _cropList.hidden = YES;
    _cropButton.selected = NO;
}

- (void)camerarollButtonDidTouchUpInside:(LmCmViewBarButton *)sender
{
    sender.selected = YES;
    [self.delegate performSelector:@selector(openCameraRoll) withObject:nil afterDelay:0.1];
}

- (void)cropButtonDidTouchUpInside:(LmCmViewBarButton *)sender
{
    _cropList.hidden = sender.selected;
    sender.selected = !sender.selected;
    
    //// Hide Settings
    _settingsList.hidden = YES;
    _settingsButton.selected = NO;
}

- (void)cameraSwitchButtonDidTouchUpInside:(LmCmViewBarButton *)sender
{
    LmCmViewController* _self = self.delegate;
    [_self.cameraManager flipCamera];
    if ([LmCmSharedCamera instance].soundEnabled == YES) {
        _flashList.hidden = YES;
        _flashButton.hidden = [_self.cameraManager isUsingFrontCamera];
        if (_flashButton.hidden == NO) {
            _flashList.hidden = !_flashButton.selected;
        }
    }else{
        _flashButton.hidden = YES;
        _flashList.hidden = YES;
    }
}

- (void)flashButtonDidTouchUpInside:(LmCmViewBarButton *)sender
{
    _flashList.hidden = sender.selected;
    sender.selected = !sender.selected;
}

- (void)flashModeDidSelect:(LmCmViewBarButtonFlashMode)mode
{
    _flashList.hidden = YES;
    _flashButton.selected = NO;
    _flashButton.flashMode = mode;
}

#pragma mark delegate

- (void)settingItemDidEnabled:(LmCmViewSettingsListItem)item
{
    LmCmSharedCamera* camera = [LmCmSharedCamera instance];
    LmCmViewController* _self = self.delegate;
    switch (item) {
        case LmCmViewSettingsListItemVolumeSnap:
            camera.volumeSnapEnabled = YES;
            break;
        case LmCmViewSettingsListItemShowZoom:
            camera.showZoomSlider = YES;
            _self.zoomViewManager.showZoomSlider = YES;
            break;
        case LmCmViewSettingsListItemShowGrid:
            camera.showGrid = YES;
            _self.cameraPreviewOverlay.showGrid = YES;
            break;
        case LmCmViewSettingsListItemEnableSound:
        {
            camera.soundEnabled = YES;
            _self.shutterButton.soundEnabled = YES;
            _flashButton.hidden = [_self.cameraManager isUsingFrontCamera];
            if (_flashButton.hidden == NO) {
                _flashList.hidden = !_flashButton.selected;
            }
        }
            break;
        default:
            break;
    }
}

- (void)settingItemDidDisabled:(LmCmViewSettingsListItem)item
{
    LmCmSharedCamera* camera = [LmCmSharedCamera instance];
    LmCmViewController* _self = self.delegate;
    switch (item) {
        case LmCmViewSettingsListItemShowZoom:
            camera.showZoomSlider = NO;
            _self.zoomViewManager.showZoomSlider = NO;
            break;
        case LmCmViewSettingsListItemVolumeSnap:
            camera.volumeSnapEnabled = NO;
            break;
        case LmCmViewSettingsListItemShowGrid:
            camera.showGrid = NO;
            _self.cameraPreviewOverlay.showGrid = NO;
            break;
        case LmCmViewSettingsListItemEnableSound:
        {
            camera.soundEnabled = NO;
            _self.shutterButton.soundEnabled = NO;
            _flashButton.hidden = YES;
            _flashList.hidden = YES;
        }
            break;
        default:
            break;
    }
}

- (void)cropSizeSelected:(LmCmViewCropSize)size
{
    LmCmViewController* _self = self.delegate;
    
    [LmCmSharedCamera instance].cropSize = size;
    [_self.blackRectView setRectWithCropSize:size];
    
}

@end

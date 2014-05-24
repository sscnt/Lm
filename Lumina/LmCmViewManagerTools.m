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
    
    //// Settings
    _settingsButton = [[LmCmViewBarButton alloc] initWithType:LmCmViewBarButtonTypeSettings];
    [_settingsButton addTarget:self action:@selector(settingsButtonDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [bar addSettingsButton:_settingsButton];
    
    //// Camera Roll
    _camerarollButton = [[LmCmViewBarButton alloc] initWithType:LmCmViewBarButtonTypeCameraRoll];
    [_camerarollButton addTarget:self action:@selector(camerarollButtonDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [bar addCamerarollButton:_camerarollButton];
    
    //// Settings
    {
        float width = 240.0f;
        float right = [_self.zoomViewManager.zoomSlider width];
        float x = [_self.cameraPreviewOverlay width] - width - right;
        float height = 44.0f + 5.0f;
        float y = [_self.cameraPreviewOverlay height] - height + 5.0f;
        _settingsList = [[LmCmViewSettingsList alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _settingsList.hidden = YES;
        _settingsList.delegate = self;
        [_self.cameraPreviewOverlay addSubview:_settingsList];
    }
}

#pragma mark button

- (void)settingsButtonDidTouchUpInside:(LmCmViewBarButton *)sender
{
    if (sender.selected) {
        _settingsList.hidden = YES;
    }else{
        _settingsList.hidden = NO;
    }
    sender.selected = !sender.selected;
}

- (void)camerarollButtonDidTouchUpInside:(LmCmViewBarButton *)sender
{
    sender.selected = YES;
    [self.delegate performSelector:@selector(openCameraRoll) withObject:nil afterDelay:0.1];
}

- (void)settingItemDidEnabled:(LmCmViewSettingsListItem)item
{
    LmCmViewController* _self = self.delegate;
    switch (item) {
        case LmCmViewSettingsListItemSquare:
            
            break;
        case LmCmViewSettingsListItemShowGrid:
            _self.cameraPreviewOverlay.showGrid = YES;
            break;
        default:
            break;
    }
}

- (void)settingItemDidDisabled:(LmCmViewSettingsListItem)item
{
    LmCmViewController* _self = self.delegate;
    switch (item) {
        case LmCmViewSettingsListItemSquare:
            
            break;
        case LmCmViewSettingsListItemShowGrid:
            _self.cameraPreviewOverlay.showGrid = NO;
            break;
        default:
            break;
    }

    
}

@end

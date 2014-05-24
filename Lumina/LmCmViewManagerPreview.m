//
//  LmViewManagerCameraPreview.m
//  Lumina
//
//  Created by SSC on 2014/05/23.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewManagerPreview.h"
#import "LmCmViewController.h"

@implementation LmCmViewManagerPreview

- (void)viewDidLoad
{
    LmCmViewController* _self = self.delegate;
    
    //// Grid
    _self.cameraPreviewOverlay.showGrid = [LmCmSharedCamera showGrid];
    
    //// Zoom slider
    float sliderWidth = 30.0f;
    _zoomSlider = [[LmCmViewZoomSlider alloc] initWithFrame:CGRectMake([UIScreen width] - sliderWidth, 0.0f, sliderWidth, 260.0f)];
    _zoomSlider.sliderStrokeColor = [UIColor whiteColor];
    _zoomSlider.sliderThumbColor = [UIColor whiteColor];
    _zoomSlider.center = CGPointMake(_zoomSlider.center.x, [_self.cameraPreviewOverlay height] / 2.0f);
    _zoomSlider.value = 0.0f;
    [_self.cameraPreviewOverlay addSubview:_zoomSlider];
}

#pragma mark zoom

- (void)showZoomSlider
{
    
}

- (void)setZoomScaleToSlider:(float)zoom
{
    _zoomSlider.value = zoom;
}

@end

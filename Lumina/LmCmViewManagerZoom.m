//
//  LmViewManagerCameraZoom.m
//  Lumina
//
//  Created by SSC on 2014/05/23.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewManagerZoom.h"
#import "LmCmViewController.h"

@implementation LmCmViewManagerZoom

- (void)viewDidLoad
{
    _currentScale = [LmCmSharedCamera instance].zoom;
    
    LmCmViewController* _self = self.delegate;
    
    //// Zoom recognizer
    UIGestureRecognizer *recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchFrom:)];
    recognizer.delegate = self;
    //[_self.cameraPreviewOverlay addGestureRecognizer:recognizer];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // gestureをセットしたview以外がタッチされた場合はgestureを無視
    if (touch.view != gestureRecognizer.view)
    {
        return false;
    }
    return true;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]]) {
        // 適用されているスケールを覚えておく
        _beginScale = _currentScale;
    }
    return YES;
}

- (void)handlePinchFrom:(UIPinchGestureRecognizer *)recognizer
{
    
    // 新しく適用するスケールを計算する (適用されているスケール x 新しくピンチしたスケール)
    _currentScale = _beginScale * recognizer.scale;
    if (_currentScale < 1.0f) {
        _currentScale = 1.0f;
    }else if(_currentScale > [LmCmSharedCamera maxZoomScaleSupported]){
        _currentScale = [LmCmSharedCamera maxZoomScaleSupported];
    }
    [self setZoom:_currentScale];
}

- (void)setZoom:(float)zoom
{
    
    LmCmViewController* _self = self.delegate;
    
    // スケールをビューに適用する
    [_self.cameraPreview.layer setAffineTransform:CGAffineTransformMakeScale(zoom, zoom)];
    [LmCmSharedCamera setZoom:zoom];
    _currentScale = zoom;
    [_self.previewManager setZoomScaleToSlider:zoom / [LmCmSharedCamera maxZoomScaleSupported]];
}

@end

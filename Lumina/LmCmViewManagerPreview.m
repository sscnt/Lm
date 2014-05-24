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
    
}

#pragma mark zoom

- (void)showZoomSlider
{
    
}

@end

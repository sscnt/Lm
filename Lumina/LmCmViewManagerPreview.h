//
//  LmViewManagerCameraPreview.h
//  Lumina
//
//  Created by SSC on 2014/05/23.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LmCmViewZoomSlider.h"

@protocol LmCmViewManagerPreviewDelegate <NSObject>

@end

@class LmCmViewController;

@interface LmCmViewManagerPreview : NSObject

@property (nonatomic, weak) UIView* view;
@property (nonatomic, weak) LmCmViewController<LmCmViewManagerPreviewDelegate>* delegate;
@property (nonatomic, strong) LmCmViewZoomSlider* zoomSlider;

- (void)viewDidLoad;

- (void)showZoomSlider;
- (void)setZoomScaleToSlider:(float)zoom;

@end

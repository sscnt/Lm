//
//  LmViewManagerCameraZoom.h
//  Lumina
//
//  Created by SSC on 2014/05/23.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LmCmViewManagerZoomDelegate <NSObject>

@end

@class LmCmViewController;

@interface LmCmViewManagerZoom : NSObject <UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIView* view;
@property (nonatomic, weak) LmCmViewController<LmCmViewManagerZoomDelegate>* delegate;
@property (nonatomic, assign) float beginScale;
@property (nonatomic, assign) float currentScale;

- (void)viewDidLoad;
- (void)setZoom:(float)zoom;

@end

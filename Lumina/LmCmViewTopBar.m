//
//  LmViewCameraTopBar.m
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewTopBar.h"

@implementation LmCmViewTopBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [LmCmSharedCamera topBarColor];
    }
    return self;
}

- (void)addCameraSwitchButton:(LmCmViewBarButton *)button
{
    button.center = CGPointMake([self width] - [button width] / 2.0f, [self height] / 2.0f);
    [self addSubview:button];
}

@end

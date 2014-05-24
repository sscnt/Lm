//
//  LmViewCameraBottomBar.m
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewBottomBar.h"

@implementation LmCmViewBottomBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [LmCmSharedCamera bottomBarColor];
    }
    return self;
}

- (void)addShutterButton:(LmCmButtonShutter *)button
{
    button.center = CGPointMake([self width] / 2.0f, [self height] / 2.0f);
    [self addSubview:button];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

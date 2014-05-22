//
//  LmViewCameraPreview.m
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmViewCameraPreviewOverlay.h"

@implementation LmViewCameraPreviewOverlay

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _flashView = [[UIView alloc] initWithFrame:self.bounds];
        _flashView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _flashView.layer.opacity = 0.0f;
        _flashView.backgroundColor = [UIColor blackColor];
        [self addSubview:_flashView];
    }
    return self;
}

- (void)flash
{
    [_flashView.layer removeAnimationForKey:@"flashAnimation"];
    CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
    flash.fromValue = [NSNumber numberWithFloat:1.0];
    flash.toValue = [NSNumber numberWithFloat:0.0];
    flash.duration = 0.20f;        // 1 second
    flash.autoreverses = NO;    // Back
    flash.repeatCount = 1;       // Or whatever
    flash.removedOnCompletion = NO;
    flash.fillMode = kCAFillModeForwards;
    
    [_flashView.layer addAnimation:flash forKey:@"flashAnimation"];
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

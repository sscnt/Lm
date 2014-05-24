//
//  LmViewCameraPreview.m
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewPreviewOverlay.h"

@implementation LmCmViewPreviewOverlay

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        _flashView = [[UIView alloc] initWithFrame:self.bounds];
        _flashView.userInteractionEnabled = YES;
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

- (void)setShowGrid:(BOOL)showGrid
{
    _showGrid = showGrid;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{

    if (_showGrid) {
        //// Color Declarations
        UIColor* color = [UIColor colorWithWhite:1.0f alpha:0.50f];
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(roundf(rect.size.width / 3.0f), 0.0f)];
        [bezierPath addLineToPoint: CGPointMake(roundf(rect.size.width / 3.0f), rect.size.height)];
        [color setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];
        
        //// Bezier Drawing
        bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(roundf(rect.size.width / 3.0f * 2.0f), 0.0f)];
        [bezierPath addLineToPoint: CGPointMake(roundf(rect.size.width / 3.0f * 2.0f), rect.size.height)];
        [color setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];
        
        //// Bezier Drawing
        bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.0f, roundf(rect.size.height / 3.0f))];
        [bezierPath addLineToPoint: CGPointMake(rect.size.width, roundf(rect.size.height / 3.0f))];
        [color setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];
        
        //// Bezier Drawing
        bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(0.0f, roundf(rect.size.height / 3.0f * 2.0f))];
        [bezierPath addLineToPoint: CGPointMake(rect.size.width, roundf(rect.size.height / 3.0f * 2.0f))];
        [color setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];
    }
}


@end

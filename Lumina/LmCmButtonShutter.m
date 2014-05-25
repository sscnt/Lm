//
//  LmButtonShutter.m
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmButtonShutter.h"

@implementation LmCmButtonShutter

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(didTouchDown:) forControlEvents:UIControlEventTouchDown];
        _holding = NO;
    }
    return self;
}

- (void)didTouchDown:(id)sender
{
    self.holding = YES;
}

- (void)setHolding:(BOOL)holding
{
    _holding = holding;
    [self setNeedsDisplay];
}

- (void)setSoundEnabled:(BOOL)soundEnabled
{
    _soundEnabled = soundEnabled;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    float lineWidth = 3.0f;
    float radius = rect.size.width / 2.0f - 6.0f;
    UIColor* color = [UIColor whiteColor];
    UIColor* ovalColor = color;
    if (_holding) {
        ovalColor = [UIColor colorWithWhite:1.0f alpha:0.10f];
    }
    UIColor* pictColor = [LmCmSharedCamera bottomBarColor];
    
    //// Stroke Drawing
    UIBezierPath* strokePath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(lineWidth / 2.0f, lineWidth / 2.0f, rect.size.width - lineWidth, rect.size.height - lineWidth)];
    [color setStroke];
    strokePath.lineWidth = lineWidth;
    [strokePath stroke];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(rect.size.width / 2.0f - radius, rect.size.height / 2.0f - radius, radius * 2.0f, radius * 2.0f)];
    [ovalColor setFill];
    [ovalPath fill];
    
    if (!_soundEnabled && !_holding) {
        
        
        //// Bezier 3 Drawing
        UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
        [bezier3Path moveToPoint: CGPointMake(35, 28.76)];
        [bezier3Path addLineToPoint: CGPointMake(34.5, 29.26)];
        [bezier3Path addLineToPoint: CGPointMake(30.87, 25.63)];
        [bezier3Path addLineToPoint: CGPointMake(35, 21.5)];
        [bezier3Path addLineToPoint: CGPointMake(35, 28.76)];
        [bezier3Path closePath];
        [bezier3Path moveToPoint: CGPointMake(30.26, 33.5)];
        [bezier3Path addLineToPoint: CGPointMake(25.26, 38.5)];
        [bezier3Path addLineToPoint: CGPointMake(21, 38.5)];
        [bezier3Path addLineToPoint: CGPointMake(21, 28.5)];
        [bezier3Path addLineToPoint: CGPointMake(25.26, 28.5)];
        [bezier3Path addLineToPoint: CGPointMake(30.26, 33.5)];
        [bezier3Path closePath];
        [bezier3Path moveToPoint: CGPointMake(35, 38.24)];
        [bezier3Path addLineToPoint: CGPointMake(35, 45.5)];
        [bezier3Path addLineToPoint: CGPointMake(30.87, 41.37)];
        [bezier3Path addLineToPoint: CGPointMake(34.5, 37.74)];
        [bezier3Path addLineToPoint: CGPointMake(35, 38.24)];
        [bezier3Path closePath];
        [bezier3Path moveToPoint: CGPointMake(34.5, 32.09)];
        [bezier3Path addLineToPoint: CGPointMake(42.99, 23.6)];
        [bezier3Path addLineToPoint: CGPointMake(44.4, 25.01)];
        [bezier3Path addLineToPoint: CGPointMake(35.91, 33.5)];
        [bezier3Path addLineToPoint: CGPointMake(44.4, 41.99)];
        [bezier3Path addLineToPoint: CGPointMake(42.99, 43.4)];
        [bezier3Path addLineToPoint: CGPointMake(34.5, 34.91)];
        [bezier3Path addLineToPoint: CGPointMake(26.01, 43.4)];
        [bezier3Path addLineToPoint: CGPointMake(24.6, 41.99)];
        [bezier3Path addLineToPoint: CGPointMake(33.09, 33.5)];
        [bezier3Path addLineToPoint: CGPointMake(24.6, 25.01)];
        [bezier3Path addLineToPoint: CGPointMake(26.01, 23.6)];
        [bezier3Path addLineToPoint: CGPointMake(34.5, 32.09)];
        [bezier3Path closePath];
        [pictColor setFill];
        [bezier3Path fill];
        
        

        
        
    }

}


@end

//
//  LmCmViewBarButton.m
//  Lumina
//
//  Created by SSC on 2014/05/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewBarButton.h"

@implementation LmCmViewBarButton

- (id)initWithType:(LmCmViewBarButtonType)type
{
    CGRect frame;
    switch (type) {
        default:
            frame = CGRectMake(0.0f, 0.0f, [LmCmSharedCamera topBarHeight], [LmCmSharedCamera topBarHeight]);
            break;
    }
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.alpha = 0.50f;
    }else{
        self.alpha = 1.0f;
    }
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = [UIColor colorWithWhite:0.90f alpha:1.0f];

    switch (_type) {
        case LmCmViewBarButtonTypeSettings:
        {            
            //// Settings Drawing
            UIBezierPath* settingsPath = [UIBezierPath bezierPath];
            [settingsPath moveToPoint: CGPointMake(23.43, 12.1)];
            [settingsPath addLineToPoint: CGPointMake(22.57, 15.02)];
            [settingsPath addCurveToPoint: CGPointMake(19.66, 16.22) controlPoint1: CGPointMake(21.5, 15.28) controlPoint2: CGPointMake(20.6, 15.66)];
            [settingsPath addLineToPoint: CGPointMake(16.98, 14.77)];
            [settingsPath addCurveToPoint: CGPointMake(14.77, 16.98) controlPoint1: CGPointMake(16.12, 15.44) controlPoint2: CGPointMake(15.44, 16.12)];
            [settingsPath addLineToPoint: CGPointMake(16.22, 19.66)];
            [settingsPath addCurveToPoint: CGPointMake(15.02, 22.57) controlPoint1: CGPointMake(15.66, 20.6) controlPoint2: CGPointMake(15.28, 21.5)];
            [settingsPath addLineToPoint: CGPointMake(12.1, 23.43)];
            [settingsPath addCurveToPoint: CGPointMake(12.1, 26.56) controlPoint1: CGPointMake(11.97, 24.52) controlPoint2: CGPointMake(11.97, 25.48)];
            [settingsPath addLineToPoint: CGPointMake(15.02, 27.43)];
            [settingsPath addCurveToPoint: CGPointMake(16.22, 30.33) controlPoint1: CGPointMake(15.28, 28.49) controlPoint2: CGPointMake(15.66, 29.4)];
            [settingsPath addLineToPoint: CGPointMake(14.77, 33.01)];
            [settingsPath addCurveToPoint: CGPointMake(16.98, 35.23) controlPoint1: CGPointMake(15.44, 33.87) controlPoint2: CGPointMake(16.12, 34.55)];
            [settingsPath addLineToPoint: CGPointMake(19.66, 33.77)];
            [settingsPath addCurveToPoint: CGPointMake(22.57, 34.97) controlPoint1: CGPointMake(20.6, 34.34) controlPoint2: CGPointMake(21.5, 34.71)];
            [settingsPath addLineToPoint: CGPointMake(23.43, 37.9)];
            [settingsPath addCurveToPoint: CGPointMake(26.56, 37.9) controlPoint1: CGPointMake(24.52, 38.03) controlPoint2: CGPointMake(25.47, 38.03)];
            [settingsPath addLineToPoint: CGPointMake(27.43, 34.97)];
            [settingsPath addCurveToPoint: CGPointMake(30.33, 33.77) controlPoint1: CGPointMake(28.49, 34.71) controlPoint2: CGPointMake(29.4, 34.34)];
            [settingsPath addLineToPoint: CGPointMake(33.01, 35.23)];
            [settingsPath addCurveToPoint: CGPointMake(35.23, 33.01) controlPoint1: CGPointMake(33.87, 34.55) controlPoint2: CGPointMake(34.55, 33.87)];
            [settingsPath addLineToPoint: CGPointMake(33.77, 30.33)];
            [settingsPath addCurveToPoint: CGPointMake(34.97, 27.43) controlPoint1: CGPointMake(34.34, 29.4) controlPoint2: CGPointMake(34.71, 28.49)];
            [settingsPath addLineToPoint: CGPointMake(37.9, 26.56)];
            [settingsPath addCurveToPoint: CGPointMake(37.9, 23.43) controlPoint1: CGPointMake(38.03, 25.48) controlPoint2: CGPointMake(38.03, 24.52)];
            [settingsPath addLineToPoint: CGPointMake(34.97, 22.57)];
            [settingsPath addCurveToPoint: CGPointMake(33.77, 19.66) controlPoint1: CGPointMake(34.71, 21.5) controlPoint2: CGPointMake(34.34, 20.6)];
            [settingsPath addLineToPoint: CGPointMake(35.23, 16.98)];
            [settingsPath addCurveToPoint: CGPointMake(33.01, 14.77) controlPoint1: CGPointMake(34.55, 16.12) controlPoint2: CGPointMake(33.87, 15.44)];
            [settingsPath addLineToPoint: CGPointMake(30.33, 16.22)];
            [settingsPath addCurveToPoint: CGPointMake(27.43, 15.02) controlPoint1: CGPointMake(29.4, 15.66) controlPoint2: CGPointMake(28.49, 15.28)];
            [settingsPath addLineToPoint: CGPointMake(26.56, 12.1)];
            [settingsPath addCurveToPoint: CGPointMake(23.43, 12.1) controlPoint1: CGPointMake(25.47, 11.97) controlPoint2: CGPointMake(24.52, 11.97)];
            [settingsPath closePath];
            [settingsPath moveToPoint: CGPointMake(20.92, 24.92)];
            [settingsPath addCurveToPoint: CGPointMake(25, 20.92) controlPoint1: CGPointMake(20.92, 22.75) controlPoint2: CGPointMake(22.83, 20.92)];
            [settingsPath addCurveToPoint: CGPointMake(29.08, 24.92) controlPoint1: CGPointMake(27.17, 20.92) controlPoint2: CGPointMake(29.08, 22.75)];
            [settingsPath addCurveToPoint: CGPointMake(25, 29.08) controlPoint1: CGPointMake(29.08, 27.09) controlPoint2: CGPointMake(27.17, 29.08)];
            [settingsPath addCurveToPoint: CGPointMake(20.92, 24.92) controlPoint1: CGPointMake(22.83, 29.08) controlPoint2: CGPointMake(20.92, 27.09)];
            [settingsPath closePath];
            settingsPath.miterLimit = 4;
            
            settingsPath.usesEvenOddFillRule = YES;
            
            [color setFill];
            [settingsPath fill];

        }
            break;
        case LmCmViewBarButtonTypeCrop:
        {
            
            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(30.09, 19)];
            [bezierPath addLineToPoint: CGPointMake(19, 19)];
            [bezierPath addLineToPoint: CGPointMake(19, 30.09)];
            [bezierPath addLineToPoint: CGPointMake(30.09, 19)];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(31.5, 20.41)];
            [bezierPath addLineToPoint: CGPointMake(20.41, 31.5)];
            [bezierPath addLineToPoint: CGPointMake(31.5, 31.5)];
            [bezierPath addLineToPoint: CGPointMake(31.5, 20.41)];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(19, 16)];
            [bezierPath addLineToPoint: CGPointMake(33.09, 16)];
            [bezierPath addLineToPoint: CGPointMake(35.63, 13.45)];
            [bezierPath addLineToPoint: CGPointMake(37.05, 14.87)];
            [bezierPath addLineToPoint: CGPointMake(34.5, 17.41)];
            [bezierPath addLineToPoint: CGPointMake(34.5, 19)];
            [bezierPath addLineToPoint: CGPointMake(34.5, 31.5)];
            [bezierPath addLineToPoint: CGPointMake(37.5, 31.5)];
            [bezierPath addLineToPoint: CGPointMake(37.5, 34.5)];
            [bezierPath addLineToPoint: CGPointMake(34.5, 34.5)];
            [bezierPath addLineToPoint: CGPointMake(34.5, 37.5)];
            [bezierPath addLineToPoint: CGPointMake(31.5, 37.5)];
            [bezierPath addLineToPoint: CGPointMake(31.5, 34.5)];
            [bezierPath addLineToPoint: CGPointMake(16, 34.5)];
            [bezierPath addLineToPoint: CGPointMake(16, 31.5)];
            [bezierPath addLineToPoint: CGPointMake(16, 19)];
            [bezierPath addLineToPoint: CGPointMake(13, 19)];
            [bezierPath addLineToPoint: CGPointMake(13, 16)];
            [bezierPath addLineToPoint: CGPointMake(16, 16)];
            [bezierPath addLineToPoint: CGPointMake(16, 13)];
            [bezierPath addLineToPoint: CGPointMake(19, 13)];
            [bezierPath addLineToPoint: CGPointMake(19, 16)];
            [bezierPath closePath];
            [color setFill];
            [bezierPath fill];
            
            
        }
            break;
        case LmCmViewBarButtonTypeCameraRoll:
        {   //// Cameraroll Drawing
            UIBezierPath* camerarollPath = [UIBezierPath bezierPath];
            [camerarollPath moveToPoint: CGPointMake(12, 33)];
            [camerarollPath addLineToPoint: CGPointMake(15, 33)];
            [camerarollPath addLineToPoint: CGPointMake(15, 15)];
            [camerarollPath addLineToPoint: CGPointMake(33, 15)];
            [camerarollPath addLineToPoint: CGPointMake(33, 12)];
            [camerarollPath addLineToPoint: CGPointMake(12, 12)];
            [camerarollPath addLineToPoint: CGPointMake(12, 33)];
            [camerarollPath closePath];
            [camerarollPath moveToPoint: CGPointMake(22.28, 24.09)];
            [camerarollPath addCurveToPoint: CGPointMake(24.09, 25.91) controlPoint1: CGPointMake(22.28, 25.1) controlPoint2: CGPointMake(23.09, 25.91)];
            [camerarollPath addCurveToPoint: CGPointMake(25.91, 24.09) controlPoint1: CGPointMake(25.1, 25.91) controlPoint2: CGPointMake(25.91, 25.1)];
            [camerarollPath addCurveToPoint: CGPointMake(24.09, 22.28) controlPoint1: CGPointMake(25.91, 23.09) controlPoint2: CGPointMake(25.1, 22.28)];
            [camerarollPath addCurveToPoint: CGPointMake(22.28, 24.09) controlPoint1: CGPointMake(23.09, 22.28) controlPoint2: CGPointMake(22.28, 23.09)];
            [camerarollPath closePath];
            [camerarollPath moveToPoint: CGPointMake(17, 17)];
            [camerarollPath addLineToPoint: CGPointMake(17, 38)];
            [camerarollPath addLineToPoint: CGPointMake(38, 38)];
            [camerarollPath addLineToPoint: CGPointMake(38, 17)];
            [camerarollPath addLineToPoint: CGPointMake(17, 17)];
            [camerarollPath closePath];
            [camerarollPath moveToPoint: CGPointMake(35, 20)];
            [camerarollPath addLineToPoint: CGPointMake(34.98, 30.44)];
            [camerarollPath addCurveToPoint: CGPointMake(31.52, 26.56) controlPoint1: CGPointMake(33.88, 29.18) controlPoint2: CGPointMake(32.03, 27.18)];
            [camerarollPath addCurveToPoint: CGPointMake(29.6, 26.36) controlPoint1: CGPointMake(30.53, 25.37) controlPoint2: CGPointMake(29.6, 26.36)];
            [camerarollPath addLineToPoint: CGPointMake(26.51, 30.21)];
            [camerarollPath addCurveToPoint: CGPointMake(28.4, 33.01) controlPoint1: CGPointMake(26.51, 30.21) controlPoint2: CGPointMake(27.35, 31.58)];
            [camerarollPath addCurveToPoint: CGPointMake(26.95, 33.7) controlPoint1: CGPointMake(28.32, 34.37) controlPoint2: CGPointMake(26.95, 33.7)];
            [camerarollPath addCurveToPoint: CGPointMake(23.98, 29.74) controlPoint1: CGPointMake(26.95, 33.7) controlPoint2: CGPointMake(24.77, 30.66)];
            [camerarollPath addCurveToPoint: CGPointMake(22.39, 29.87) controlPoint1: CGPointMake(23.18, 28.81) controlPoint2: CGPointMake(22.39, 29.87)];
            [camerarollPath addLineToPoint: CGPointMake(19.86, 32.79)];
            [camerarollPath addLineToPoint: CGPointMake(20, 20)];
            [camerarollPath addLineToPoint: CGPointMake(35, 20)];
            [camerarollPath closePath];
            camerarollPath.miterLimit = 4;
            
            camerarollPath.usesEvenOddFillRule = YES;
            
            [color setFill];
            [camerarollPath fill];

        }
            break;
    }
}


@end
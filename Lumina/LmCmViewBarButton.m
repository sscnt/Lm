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
        case LmCmViewBarButtonTypeSwitchCamera:
            frame = CGRectMake(0.0f, 0.0f, [LmCmSharedCamera topBarHeight], [LmCmSharedCamera topBarHeight]);
            break;
        default:
            frame = CGRectMake(0.0f, 0.0f, [LmCmSharedCamera topBarHeight], [LmCmSharedCamera bottomBarHeight]);
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
            [settingsPath moveToPoint: CGPointMake(21.43, 31.1)];
            [settingsPath addLineToPoint: CGPointMake(20.57, 34.02)];
            [settingsPath addCurveToPoint: CGPointMake(17.66, 35.22) controlPoint1: CGPointMake(19.5, 34.28) controlPoint2: CGPointMake(18.6, 34.66)];
            [settingsPath addLineToPoint: CGPointMake(14.98, 33.77)];
            [settingsPath addCurveToPoint: CGPointMake(12.77, 35.98) controlPoint1: CGPointMake(14.12, 34.44) controlPoint2: CGPointMake(13.44, 35.12)];
            [settingsPath addLineToPoint: CGPointMake(14.22, 38.66)];
            [settingsPath addCurveToPoint: CGPointMake(13.02, 41.57) controlPoint1: CGPointMake(13.66, 39.6) controlPoint2: CGPointMake(13.28, 40.5)];
            [settingsPath addLineToPoint: CGPointMake(10.1, 42.43)];
            [settingsPath addCurveToPoint: CGPointMake(10.1, 45.56) controlPoint1: CGPointMake(9.97, 43.52) controlPoint2: CGPointMake(9.97, 44.48)];
            [settingsPath addLineToPoint: CGPointMake(13.02, 46.43)];
            [settingsPath addCurveToPoint: CGPointMake(14.22, 49.33) controlPoint1: CGPointMake(13.28, 47.49) controlPoint2: CGPointMake(13.66, 48.4)];
            [settingsPath addLineToPoint: CGPointMake(12.77, 52.01)];
            [settingsPath addCurveToPoint: CGPointMake(14.98, 54.23) controlPoint1: CGPointMake(13.44, 52.87) controlPoint2: CGPointMake(14.12, 53.55)];
            [settingsPath addLineToPoint: CGPointMake(17.66, 52.77)];
            [settingsPath addCurveToPoint: CGPointMake(20.57, 53.97) controlPoint1: CGPointMake(18.6, 53.34) controlPoint2: CGPointMake(19.5, 53.71)];
            [settingsPath addLineToPoint: CGPointMake(21.43, 56.9)];
            [settingsPath addCurveToPoint: CGPointMake(24.56, 56.9) controlPoint1: CGPointMake(22.52, 57.03) controlPoint2: CGPointMake(23.47, 57.03)];
            [settingsPath addLineToPoint: CGPointMake(25.43, 53.97)];
            [settingsPath addCurveToPoint: CGPointMake(28.33, 52.77) controlPoint1: CGPointMake(26.49, 53.71) controlPoint2: CGPointMake(27.4, 53.34)];
            [settingsPath addLineToPoint: CGPointMake(31.01, 54.23)];
            [settingsPath addCurveToPoint: CGPointMake(33.23, 52.01) controlPoint1: CGPointMake(31.87, 53.55) controlPoint2: CGPointMake(32.55, 52.87)];
            [settingsPath addLineToPoint: CGPointMake(31.77, 49.33)];
            [settingsPath addCurveToPoint: CGPointMake(32.97, 46.43) controlPoint1: CGPointMake(32.34, 48.4) controlPoint2: CGPointMake(32.71, 47.49)];
            [settingsPath addLineToPoint: CGPointMake(35.9, 45.56)];
            [settingsPath addCurveToPoint: CGPointMake(35.9, 42.43) controlPoint1: CGPointMake(36.03, 44.48) controlPoint2: CGPointMake(36.03, 43.52)];
            [settingsPath addLineToPoint: CGPointMake(32.97, 41.57)];
            [settingsPath addCurveToPoint: CGPointMake(31.77, 38.66) controlPoint1: CGPointMake(32.71, 40.5) controlPoint2: CGPointMake(32.34, 39.6)];
            [settingsPath addLineToPoint: CGPointMake(33.23, 35.98)];
            [settingsPath addCurveToPoint: CGPointMake(31.01, 33.77) controlPoint1: CGPointMake(32.55, 35.12) controlPoint2: CGPointMake(31.87, 34.44)];
            [settingsPath addLineToPoint: CGPointMake(28.33, 35.22)];
            [settingsPath addCurveToPoint: CGPointMake(25.43, 34.02) controlPoint1: CGPointMake(27.4, 34.66) controlPoint2: CGPointMake(26.49, 34.28)];
            [settingsPath addLineToPoint: CGPointMake(24.56, 31.1)];
            [settingsPath addCurveToPoint: CGPointMake(21.43, 31.1) controlPoint1: CGPointMake(23.47, 30.97) controlPoint2: CGPointMake(22.52, 30.97)];
            [settingsPath closePath];
            [settingsPath moveToPoint: CGPointMake(18.92, 43.92)];
            [settingsPath addCurveToPoint: CGPointMake(23, 39.92) controlPoint1: CGPointMake(18.92, 41.75) controlPoint2: CGPointMake(20.83, 39.92)];
            [settingsPath addCurveToPoint: CGPointMake(27.08, 43.92) controlPoint1: CGPointMake(25.17, 39.92) controlPoint2: CGPointMake(27.08, 41.75)];
            [settingsPath addCurveToPoint: CGPointMake(23, 48.08) controlPoint1: CGPointMake(27.08, 46.09) controlPoint2: CGPointMake(25.17, 48.08)];
            [settingsPath addCurveToPoint: CGPointMake(18.92, 43.92) controlPoint1: CGPointMake(20.83, 48.08) controlPoint2: CGPointMake(18.92, 46.09)];
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
            [bezierPath moveToPoint: CGPointMake(27.09, 39)];
            [bezierPath addLineToPoint: CGPointMake(16, 39)];
            [bezierPath addLineToPoint: CGPointMake(16, 50.09)];
            [bezierPath addLineToPoint: CGPointMake(27.09, 39)];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(28.5, 40.41)];
            [bezierPath addLineToPoint: CGPointMake(17.41, 51.5)];
            [bezierPath addLineToPoint: CGPointMake(28.5, 51.5)];
            [bezierPath addLineToPoint: CGPointMake(28.5, 40.41)];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(16, 36)];
            [bezierPath addLineToPoint: CGPointMake(30.09, 36)];
            [bezierPath addLineToPoint: CGPointMake(32.63, 33.45)];
            [bezierPath addLineToPoint: CGPointMake(34.05, 34.87)];
            [bezierPath addLineToPoint: CGPointMake(31.5, 37.41)];
            [bezierPath addLineToPoint: CGPointMake(31.5, 39)];
            [bezierPath addLineToPoint: CGPointMake(31.5, 51.5)];
            [bezierPath addLineToPoint: CGPointMake(34.5, 51.5)];
            [bezierPath addLineToPoint: CGPointMake(34.5, 54.5)];
            [bezierPath addLineToPoint: CGPointMake(31.5, 54.5)];
            [bezierPath addLineToPoint: CGPointMake(31.5, 57.5)];
            [bezierPath addLineToPoint: CGPointMake(28.5, 57.5)];
            [bezierPath addLineToPoint: CGPointMake(28.5, 54.5)];
            [bezierPath addLineToPoint: CGPointMake(13, 54.5)];
            [bezierPath addLineToPoint: CGPointMake(13, 51.5)];
            [bezierPath addLineToPoint: CGPointMake(13, 39)];
            [bezierPath addLineToPoint: CGPointMake(10, 39)];
            [bezierPath addLineToPoint: CGPointMake(10, 36)];
            [bezierPath addLineToPoint: CGPointMake(13, 36)];
            [bezierPath addLineToPoint: CGPointMake(13, 33)];
            [bezierPath addLineToPoint: CGPointMake(16, 33)];
            [bezierPath addLineToPoint: CGPointMake(16, 36)];
            [bezierPath closePath];
            [color setFill];
            [bezierPath fill];
            
        }
            break;
        case LmCmViewBarButtonTypeCameraRoll:
        {
            //// Cameraroll Drawing
            UIBezierPath* camerarollPath = [UIBezierPath bezierPath];
            [camerarollPath moveToPoint: CGPointMake(10, 52)];
            [camerarollPath addLineToPoint: CGPointMake(13, 52)];
            [camerarollPath addLineToPoint: CGPointMake(13, 34)];
            [camerarollPath addLineToPoint: CGPointMake(31, 34)];
            [camerarollPath addLineToPoint: CGPointMake(31, 31)];
            [camerarollPath addLineToPoint: CGPointMake(10, 31)];
            [camerarollPath addLineToPoint: CGPointMake(10, 52)];
            [camerarollPath closePath];
            [camerarollPath moveToPoint: CGPointMake(20.28, 43.09)];
            [camerarollPath addCurveToPoint: CGPointMake(22.09, 44.91) controlPoint1: CGPointMake(20.28, 44.1) controlPoint2: CGPointMake(21.09, 44.91)];
            [camerarollPath addCurveToPoint: CGPointMake(23.91, 43.09) controlPoint1: CGPointMake(23.1, 44.91) controlPoint2: CGPointMake(23.91, 44.1)];
            [camerarollPath addCurveToPoint: CGPointMake(22.09, 41.28) controlPoint1: CGPointMake(23.91, 42.09) controlPoint2: CGPointMake(23.1, 41.28)];
            [camerarollPath addCurveToPoint: CGPointMake(20.28, 43.09) controlPoint1: CGPointMake(21.09, 41.28) controlPoint2: CGPointMake(20.28, 42.09)];
            [camerarollPath closePath];
            [camerarollPath moveToPoint: CGPointMake(15, 36)];
            [camerarollPath addLineToPoint: CGPointMake(15, 57)];
            [camerarollPath addLineToPoint: CGPointMake(36, 57)];
            [camerarollPath addLineToPoint: CGPointMake(36, 36)];
            [camerarollPath addLineToPoint: CGPointMake(15, 36)];
            [camerarollPath closePath];
            [camerarollPath moveToPoint: CGPointMake(33, 39)];
            [camerarollPath addLineToPoint: CGPointMake(32.98, 49.44)];
            [camerarollPath addCurveToPoint: CGPointMake(29.52, 45.56) controlPoint1: CGPointMake(31.88, 48.18) controlPoint2: CGPointMake(30.03, 46.18)];
            [camerarollPath addCurveToPoint: CGPointMake(27.6, 45.36) controlPoint1: CGPointMake(28.53, 44.37) controlPoint2: CGPointMake(27.6, 45.36)];
            [camerarollPath addLineToPoint: CGPointMake(24.51, 49.21)];
            [camerarollPath addCurveToPoint: CGPointMake(26.4, 52.01) controlPoint1: CGPointMake(24.51, 49.21) controlPoint2: CGPointMake(25.35, 50.58)];
            [camerarollPath addCurveToPoint: CGPointMake(24.95, 52.7) controlPoint1: CGPointMake(26.32, 53.37) controlPoint2: CGPointMake(24.95, 52.7)];
            [camerarollPath addCurveToPoint: CGPointMake(21.98, 48.74) controlPoint1: CGPointMake(24.95, 52.7) controlPoint2: CGPointMake(22.77, 49.66)];
            [camerarollPath addCurveToPoint: CGPointMake(20.39, 48.87) controlPoint1: CGPointMake(21.18, 47.81) controlPoint2: CGPointMake(20.39, 48.87)];
            [camerarollPath addLineToPoint: CGPointMake(17.86, 51.79)];
            [camerarollPath addLineToPoint: CGPointMake(18, 39)];
            [camerarollPath addLineToPoint: CGPointMake(33, 39)];
            [camerarollPath closePath];
            camerarollPath.miterLimit = 4;
            
            camerarollPath.usesEvenOddFillRule = YES;
            
            [color setFill];
            [camerarollPath fill];
            


        }
            break;
        case LmCmViewBarButtonTypeSwitchCamera:
        {
            
            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(32.42, 17.58)];
            [bezierPath addCurveToPoint: CGPointMake(35.5, 25) controlPoint1: CGPointMake(34.47, 19.63) controlPoint2: CGPointMake(35.5, 22.31)];
            [bezierPath addLineToPoint: CGPointMake(38, 25)];
            [bezierPath addLineToPoint: CGPointMake(34, 31)];
            [bezierPath addLineToPoint: CGPointMake(30, 25)];
            [bezierPath addLineToPoint: CGPointMake(32.5, 25)];
            [bezierPath addCurveToPoint: CGPointMake(30.3, 19.7) controlPoint1: CGPointMake(32.5, 23.08) controlPoint2: CGPointMake(31.77, 21.16)];
            [bezierPath addCurveToPoint: CGPointMake(20.17, 19.26) controlPoint1: CGPointMake(27.53, 16.92) controlPoint2: CGPointMake(23.12, 16.78)];
            [bezierPath addLineToPoint: CGPointMake(18.5, 16.75)];
            [bezierPath addCurveToPoint: CGPointMake(32.42, 17.58) controlPoint1: CGPointMake(22.62, 13.5) controlPoint2: CGPointMake(28.62, 13.77)];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(20, 25)];
            [bezierPath addLineToPoint: CGPointMake(17.5, 25)];
            [bezierPath addCurveToPoint: CGPointMake(19.7, 30.3) controlPoint1: CGPointMake(17.5, 26.92) controlPoint2: CGPointMake(18.23, 28.84)];
            [bezierPath addCurveToPoint: CGPointMake(29.83, 30.74) controlPoint1: CGPointMake(22.47, 33.08) controlPoint2: CGPointMake(26.88, 33.22)];
            [bezierPath addLineToPoint: CGPointMake(31.5, 33.25)];
            [bezierPath addCurveToPoint: CGPointMake(17.58, 32.42) controlPoint1: CGPointMake(27.38, 36.5) controlPoint2: CGPointMake(21.38, 36.23)];
            [bezierPath addCurveToPoint: CGPointMake(14.5, 25) controlPoint1: CGPointMake(15.53, 30.37) controlPoint2: CGPointMake(14.5, 27.69)];
            [bezierPath addLineToPoint: CGPointMake(12, 25)];
            [bezierPath addLineToPoint: CGPointMake(16, 19)];
            [bezierPath addLineToPoint: CGPointMake(20, 25)];
            [bezierPath closePath];
            [color setFill];
            [bezierPath fill];
            
            

        }
            break;
    }
}


@end

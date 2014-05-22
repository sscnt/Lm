//
//  LmButtonShutter.m
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmButtonShutter.h"

@implementation LmButtonShutter

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    float lineWidth = 2.0f;
    float radius = rect.size.width / 2.0f - 5.0f;
    UIColor* color = [UIColor whiteColor];
    
    //// Stroke Drawing
    UIBezierPath* strokePath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(lineWidth / 2.0f, lineWidth / 2.0f, rect.size.width - lineWidth, rect.size.height - lineWidth)];
    [color setStroke];
    strokePath.lineWidth = lineWidth;
    [strokePath stroke];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(rect.size.width / 2.0f - radius, rect.size.height / 2.0f - radius, radius * 2.0f, radius * 2.0f)];
    [color setFill];
    [ovalPath fill];

}


@end

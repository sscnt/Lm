//
//  LmCmButtonSettingsItem.m
//  Lumina
//
//  Created by SSC on 2014/05/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmButtonSettingsItem.h"

@implementation LmCmButtonSettingsItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float padding = 40.0f;
        self.backgroundColor = [UIColor clearColor];
        _label = [[VnViewLabel alloc] initWithFrame:CGRectMake(padding, 0.0f, frame.size.width - padding, frame.size.height)];
        _label.fontSize = 17.0f;
        _label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_label];
    }
    return self;
}

- (void)setActive:(BOOL)active
{
    _active = active;
    if (active) {
        self.alpha = 1.0f;
    }else{
        self.alpha = 0.30f;
    }
}

- (void)setItem:(LmCmViewSettingsListItem)item
{
    _item = item;
    switch (item) {
        case LmCmViewSettingsListItemSquare:
            _label.text = NSLocalizedString(@"Square", nil);
            break;
        case LmCmViewSettingsListItemShowGrid:
            _label.text = NSLocalizedString(@"Grid", nil);
            break;
        default:
            break;
    }
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    
    switch (_item) {
        case LmCmViewSettingsListItemShowGrid:
        {
            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(19, 15)];
            [bezierPath addLineToPoint: CGPointMake(19, 30)];
            [color setStroke];
            bezierPath.lineWidth = 2;
            [bezierPath stroke];
            
            
            //// Bezier 2 Drawing
            UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
            [bezier2Path moveToPoint: CGPointMake(26, 15)];
            [bezier2Path addLineToPoint: CGPointMake(26, 30)];
            [color setStroke];
            bezier2Path.lineWidth = 2;
            [bezier2Path stroke];
            
            
            //// Bezier 3 Drawing
            UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
            [bezier3Path moveToPoint: CGPointMake(15, 19)];
            [bezier3Path addLineToPoint: CGPointMake(30, 19)];
            [color setStroke];
            bezier3Path.lineWidth = 2;
            [bezier3Path stroke];
            
            
            //// Bezier 4 Drawing
            UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
            [bezier4Path moveToPoint: CGPointMake(15, 26)];
            [bezier4Path addLineToPoint: CGPointMake(30, 26)];
            [color setStroke];
            bezier4Path.lineWidth = 2;
            [bezier4Path stroke];
        }
            break;
        case LmCmViewSettingsListItemSquare:
        {
            //// Rectangle Drawing
            UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(15, 15, 15, 15)];
            [color setStroke];
            rectanglePath.lineWidth = 2;
            [rectanglePath stroke];
        }
            break;
        default:
            break;
    }
}


@end

//
//  LmCmViewSettingsList.m
//  Lumina
//
//  Created by SSC on 2014/05/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewSettingsList.h"

@implementation LmCmViewSettingsList

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        LmCmButtonSettingsItem* button;
        float itemWidth = frame.size.width / 2.0f;
        float itemHeight = 44.0f;
        CGRect buttonFrame = CGRectMake(0.0f, 0.0f, itemWidth, itemHeight);
        
        //// Grid
        button = [[LmCmButtonSettingsItem alloc] initWithFrame:buttonFrame];
        button.item = LmCmViewSettingsListItemShowGrid;
        [button setX:0.0f];
        [button setY:0.0f];
        [button addTarget:self action:@selector(didSelectItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        //// Square
        button = [[LmCmButtonSettingsItem alloc] initWithFrame:buttonFrame];
        button.item = LmCmViewSettingsListItemSquare;
        [button setX:itemWidth];
        [button setY:0.0f];
        [button addTarget:self action:@selector(didSelectItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    return self;
}

- (void)didSelectItem:(LmCmButtonSettingsItem *)item
{
    item.active = !item.active;
    if (item.active) {
        [self.delegate settingItemDidEnabled:item.item];
    }else{
        [self.delegate settingItemDidDisabled:item.item];
    }
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = [LmCmSharedCamera settingsBgColor];
    
    //// Rounded Rectangle Drawing
    UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: rect byRoundingCorners: UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii: CGSizeMake(3, 3)];
    [roundedRectanglePath closePath];
    [color setFill];
    [roundedRectanglePath fill];
}


@end

//
//  LmCmViewBarButton.h
//  Lumina
//
//  Created by SSC on 2014/05/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LmCmViewBarButtonType){
    LmCmViewBarButtonTypeCameraRoll = 1,
    LmCmViewBarButtonTypeLastPhoto,
    LmCmViewBarButtonTypeSettings,
    LmCmViewBarButtonTypeFlash
};

@interface LmCmViewBarButton : UIButton

@property (nonatomic, assign) LmCmViewBarButtonType type;

- (id)initWithType:(LmCmViewBarButtonType)type;

@end

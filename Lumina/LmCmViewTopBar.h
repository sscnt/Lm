//
//  LmViewCameraTopBar.h
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LmCmViewBarButton.h"

@interface LmCmViewTopBar : UIView

- (void)addCameraSwitchButton:(LmCmViewBarButton*)button;
- (void)addFlashButton:(LmCmViewBarButton*)button;

@end

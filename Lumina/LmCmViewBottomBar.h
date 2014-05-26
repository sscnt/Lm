//
//  LmViewCameraBottomBar.h
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LmCmButtonShutter.h"
#import "LmCmViewBarButton.h"

@interface LmCmViewBottomBar : UIView

- (void)addShutterButton:(LmCmButtonShutter*)button;
- (void)addSettingsButton:(LmCmViewBarButton*)button;
- (void)addCamerarollButton:(LmCmViewBarButton*)button;
- (void)addLastPhotoButton:(LmCmViewBarButton*)button;
- (void)addCropButton:(LmCmViewBarButton*)button;

@end

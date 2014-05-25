//
//  LmCmViewManagerTools.h
//  Lumina
//
//  Created by SSC on 2014/05/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LmCmViewBarButton.h"
#import "LmCmViewSettingsList.h"
#import "LmCmViewCropList.h"

@protocol LmCmViewManagerToolsDelegate <NSObject>
- (void)openCameraRoll;
@end

@class LmCmViewController;

@interface LmCmViewManagerTools : NSObject <LmCmViewSettingsListDelegate, LmCmViewCropListDelegate>

@property (nonatomic, weak) UIView* view;
@property (nonatomic, weak) LmCmViewController<LmCmViewManagerToolsDelegate>* delegate;
@property (nonatomic, strong) LmCmViewBarButton* settingsButton;
@property (nonatomic, strong) LmCmViewBarButton* camerarollButton;
@property (nonatomic, strong) LmCmViewBarButton* cropButton;
@property (nonatomic, strong) LmCmViewSettingsList* settingsList;
@property (nonatomic, strong) LmCmViewCropList* cropList;

- (void)viewDidLoad;
- (void)showSettingsList;

- (void)settingsButtonDidTouchUpInside:(LmCmViewBarButton*)sender;
- (void)camerarollButtonDidTouchUpInside:(LmCmViewBarButton*)sender;
- (void)cropButtonDidTouchUpInside:(LmCmViewBarButton*)sender;

@end

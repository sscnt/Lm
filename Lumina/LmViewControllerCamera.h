//
//  ViewController.h
//  Lumina
//
//  Created by SSC on 2014/05/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraManager.h"

@interface LmViewControllerCamera : UIViewController

@property (nonatomic, strong) CameraManager* cameraManager;
@property (nonatomic, strong) UIView* cameraPreview;

@end

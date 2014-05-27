//
//  AppDelegate.h
//  Lumina
//
//  Created by SSC on 2014/05/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LmViewControllerRoot.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, weak) LmViewControllerRoot* rootViewController;

@end

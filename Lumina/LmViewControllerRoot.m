//
//  LmViewControllerRoot.m
//  Lumina
//
//  Created by SSC on 2014/05/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmViewControllerRoot.h"
#import "AppDelegate.h"

@interface LmViewControllerRoot ()

@end

@implementation LmViewControllerRoot

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *appdelegate = [[UIApplication sharedApplication] delegate];
    appdelegate.rootViewController = self;
    
    [self.navigationBar setHidden:YES];
    self.delegate = self;
    
    _lmCmViewController = [[LmCmViewController alloc] init];
    [self pushViewController:_lmCmViewController animated:NO];
    
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //スワイプによる戻るを無効にする(スワイプを少しして戻すとNavigationBarが存在しなくなる事象回避)
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
}

#pragma mark application

- (void)applicationDidEnterBackground
{
    [self.lmCmViewController disableCamera];
}

- (void)applicationWillEnterForeground
{
    [self.lmCmViewController enableCamera];
    [self.lmCmViewController loadLastPhoto];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

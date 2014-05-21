//
//  ViewController.m
//  Lumina
//
//  Created by SSC on 2014/05/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmViewControllerCamera.h"

@interface LmViewControllerCamera ()

@end

@implementation LmViewControllerCamera

- (void)viewDidLoad
{
    [super viewDidLoad];
    //// camera
    _cameraManager = [[CameraManager alloc] init];
    
    //// Preview
    _cameraPreview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 50.0f, [UIScreen width], [UIScreen height] - 50.0f - 88.0f)];
    [self.view addSubview:_cameraPreview];
    [_cameraManager setPreview:_cameraPreview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

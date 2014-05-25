//
//  ViewController.m
//  Lumina
//
//  Created by SSC on 2014/05/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCmViewController.h"

@interface LmCmViewController ()

@end

@implementation LmCmViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initVolumeHandling];
    
    [MotionOrientation initialize];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(orientationDidChange) name:@"MotionOrientationChangedNotification" object:nil];
    
    _zoomViewManager = [[LmCmViewManagerZoom alloc] init];
    _zoomViewManager.view = self.view;
    _zoomViewManager.delegate = self;
    _previewManager = [[LmCmViewManagerPreview alloc] init];
    _previewManager.view = self.view;
    _previewManager.delegate = self;
    _toolsManager = [[LmCmViewManagerTools alloc] init];
    _toolsManager.delegate = self;
    _toolsManager.view = self.view;
    
    //// camera
    _cameraManager = [[LmCmCameraManager alloc] init];
    _cameraManager.delegate = self;
    
    //// Preview
    _cameraPreview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, [LmCmSharedCamera topBarHeight], [UIScreen width], [UIScreen height] - [LmCmSharedCamera topBarHeight] - [LmCmSharedCamera bottomBarHeight])];
    [self.view addSubview:_cameraPreview];
    [_cameraManager setPreview:_cameraPreview];
    
    //// Black rect
    _blackRectView = [[LmCmViewCropBlackRect alloc] initWithFrame:_cameraPreview.frame];
    [_blackRectView setRectWithCropSize:[LmCmSharedCamera instance].cropSize];
    [self.view addSubview:_blackRectView];
    
    //// Overlay
    _cameraPreviewOverlay = [[LmCmViewPreviewOverlay alloc] initWithFrame:_cameraPreview.frame];
    [self.view addSubview:_cameraPreviewOverlay];
        
    //// Bar
    _topBar = [[LmCmViewTopBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen width], [LmCmSharedCamera topBarHeight])];
    [self.view addSubview:_topBar];
    _bottomBar = [[LmCmViewBottomBar alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen width], [LmCmSharedCamera bottomBarHeight])];
    [_bottomBar setY:[UIScreen height] - [_bottomBar height]];
    [self.view addSubview:_bottomBar];
    
    //// Shutter
    _shutterButton = [[LmCmButtonShutter alloc] initWithFrame:[LmCmSharedCamera shutterButtonRect]];
    _shutterButton.soundEnabled = [LmCmSharedCamera instance].soundEnabled;
    [_shutterButton addTarget:self action:@selector(didShutterButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_shutterButton addTarget:self action:@selector(didShutterButtonTouchCancel:) forControlEvents:UIControlEventTouchUpOutside];
    [_bottomBar addShutterButton:_shutterButton];
    
    //// View did load
    [_zoomViewManager viewDidLoad];
    [_previewManager viewDidLoad];
    [_toolsManager viewDidLoad];
}

#pragma mark shutter

- (void)didShutterButtonTouchUpInside:(id)sender
{
    ((LmCmButtonShutter*)sender).holding = NO;
    if ([LmCmSharedCamera instance].soundEnabled) {
        [_cameraPreviewOverlay flash];
    }
    [_cameraManager takeAPhoto];
}

- (void)didShutterButtonTouchCancel:(id)sender
{
    ((LmCmButtonShutter*)sender).holding = NO;    
}

#pragma mark delegate

#pragma makr camera delegate
- (void)singleImageSavedWithOrientation:(UIDeviceOrientation)orientation
{
    LOG(@"photo saved.");
    [_cameraPreviewOverlay flash];
    
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        @autoreleasepool
        {
            UIImage* image = [LmCurrentImage tmpImage];
            float zoom = [LmCmSharedCamera instance].zoom;
            if (zoom != 1.0f) {
                float width = roundf(image.size.width / zoom);
                float height = roundf(image.size.height / zoom);
                float afterWidth = image.size.width;
                float afterHeight = image.size.height;
                float length = MAX(width, height);
                if (length < 1920.0f) {
                    afterWidth = roundf(afterWidth / 2.0f);
                    afterHeight = roundf(afterHeight / 2.0f);
                }
                float x = roundf((image.size.width - width) / 2.0f);
                float y = roundf((image.size.height - height) / 2.0f);
                @autoreleasepool {
                    image = [image croppedImage:CGRectMake(x, y, width, height)];
                    //image = [image resizedImage:CGSizeMake(afterWidth, afterHeight) interpolationQuality:kCGInterpolationHigh];
                }
            }
            switch (orientation) {
                case UIDeviceOrientationUnknown:
                    break;
                case UIDeviceOrientationPortraitUpsideDown:
                    image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationLeft];
                    break;
                case UIDeviceOrientationPortrait:
                    image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationRight];
                    break;
                case UIDeviceOrientationLandscapeLeft:
                    break;
                case UIDeviceOrientationLandscapeRight:
                    image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationDown];
                    break;
                default:
                    break;
            }
            
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }
        dispatch_async(q_main, ^{
            
        });
    });
}

- (void)singleImageDidTake:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

#pragma mark camera roll


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([[[viewController class] description] isEqualToString:@"PUUIAlbumListViewController"]) {
        self.toolsManager.camerarollButton.selected = NO;
    }
}

- (void)openCameraRoll
{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    [pickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* imageOriginal = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if(imageOriginal){
        if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
            UIImageWriteToSavedPhotosAlbum(imageOriginal, nil, nil, nil);
        }
        //// Do your stuff
        
    } else {
        NSURL* imageurl = [info objectForKey:UIImagePickerControllerReferenceURL];
        ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
        [library assetForURL:imageurl
                 resultBlock: ^(ALAsset *asset)
         {
             ALAssetRepresentation *representation;
             representation = [asset defaultRepresentation];
             UIImage* imageOriginal = [[UIImage alloc] initWithCGImage:representation.fullResolutionImage];
             //// Do your stuff
             
         }
                failureBlock:^(NSError *error)
         {
         }
         ];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)orientationDidChange
{
    __block LmCmViewController* _self = self;
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_main, ^{
        [_self.blackRectView setRectWithCropSize:[LmCmSharedCamera instance].cropSize];
        [_self.cameraPreviewOverlay setNeedsDisplay];
    });
    
    
}

#pragma mark volume

- (void)initVolumeHandling
{
    [self setVolumeNotification];
    
    //MPVolumeViewをオフスクリーンに。
    CGRect frame = CGRectMake(-100, -100, 100, 100);
    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:frame];
    [volumeView sizeToFit];
    [self.view addSubview:volumeView];
    
    AudioSessionInitialize(NULL, NULL, NULL, NULL);
    UInt32 category = kAudioSessionCategory_AmbientSound;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(category), &category);
    AudioSessionSetActive(true);
    
    initialVolume = [MPMusicPlayerController applicationMusicPlayer].volume;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [center addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
}

- (void)setVolumeNotification {
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(volumeChanged:)
     name:@"AVSystemController_SystemVolumeDidChangeNotification"
     object:nil];
}

- (void)volumeChanged:(NSNotification *)notification{
    //明示的にボリューム変更がされた時のみ
    if ([[[notification userInfo]objectForKey:@"AVSystemController_AudioVolumeChangeReasonNotificationParameter"]isEqualToString:@"ExplicitVolumeChange"]) {
        
        //ここで撮影をおこなうメソッド等を呼ぶ
        if ([LmCmSharedCamera instance].volumeSnapEnabled) {
            [self didShutterButtonTouchUpInside:_shutterButton];
        }
        
        //一旦NSNotificationCenterからAVSystemController_SystemVolumeDidChangeNotificationを外して、ボリュームを元に戻す
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
        [MPMusicPlayerController applicationMusicPlayer].volume = initialVolume;
        [self performSelector:@selector(setVolumeNotification) withObject:nil afterDelay:0.2];
    }
}

- (void)applicationDidEnterBackground:(NSNotification *)notification {
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    AudioSessionSetActive(false);
}

- (void)applicationWillEnterForeground:(NSNotification *)notification {
    initialVolume = [MPMusicPlayerController applicationMusicPlayer].volume;
    [self setVolumeNotification];
    AudioSessionSetActive(true);
}

@end

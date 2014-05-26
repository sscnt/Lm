//
//  CameraManager.m
//  CameraTemplate
//
//  Created by Takashi Otsuka on 2013/06/16.
//  Copyright (c) 2013年 takatronix.com. All rights reserved.
//

#import "LmCmCameraManager.h"

@interface LmCmCameraManager(){

    AVCaptureSession*               captureSession;
    AVCaptureDeviceInput*           videoInput;             //  現在のビデオ入力デバイス
    
    AVCaptureStillImageOutput*      imageOutput;            //  静止画出力デバイス
    AVCaptureAudioDataOutput*       audioOutput;            //  オーディオ出力デバイス
    AVCaptureVideoDataOutput*       videoOutput;            //  ビデオ出力デバイス
    dispatch_queue_t                videoOutputQueue;       //  ビデオ出力用スレッド
    dispatch_queue_t                audioOutputQueue;       //  オーディオ出力用スレッド
}

//          ユーティリティ
- (AVCaptureDevice *) cameraWithPosition:(AVCaptureDevicePosition)position;
- (AVCaptureDevice *) frontFacingCamera;
- (AVCaptureDevice *) backFacingCamera;
- (AVCaptureDevice *) audioDevice;

@end

@implementation LmCmCameraManager


#pragma mark - カメラ切り替え

-(void)useFrontCamera:(BOOL)yesno{
    
    if(yesno == YES){
        [self enableCamera:AVCaptureDevicePositionFront];
    }else{
        [self enableCamera:AVCaptureDevicePositionBack];
    }
    
}
-(void)flipCamera{
    
    if(self.isUsingFrontCamera)
        [self useFrontCamera:NO];
    else
        [self useFrontCamera:YES];
}
//     カメラを有効化する
-(void)enableCamera:(AVCaptureDevicePosition)desiredPosition{
    [captureSession stopRunning];
    
    for (AVCaptureDevice *d in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]) {
        if ([d position] == desiredPosition) {
            [captureSession beginConfiguration];
            videoInput= [AVCaptureDeviceInput deviceInputWithDevice:d error:nil];
            for (AVCaptureInput *oldInput in [[_previewLayer session] inputs]) {
                [captureSession removeInput:oldInput];
            }
            [captureSession addInput:videoInput];
            [captureSession commitConfiguration];
            break;
        }
    }
    [captureSession startRunning];
}

-(BOOL)isUsingFrontCamera{

    //      フロントカメラを使っているか
   if(videoInput.device.position == AVCaptureDevicePositionFront)
       return YES;

    return NO;
}

#pragma mark - ライト制御

- (void)flash:(BOOL)enabled
{
    [_backCameraDevice lockForConfiguration:nil];
    if (enabled) {
        _backCameraDevice.flashMode = AVCaptureFlashModeOn;
    }else{
        _backCameraDevice.flashMode = AVCaptureFlashModeOff;
    }
    [_backCameraDevice unlockForConfiguration];
}

- (void)autoFlash:(BOOL)enabled
{
    [_backCameraDevice lockForConfiguration:nil];
    if (enabled) {
        _backCameraDevice.flashMode = AVCaptureFlashModeAuto;
    }else{
        _backCameraDevice.flashMode = AVCaptureFlashModeOff;
    }
    [_backCameraDevice unlockForConfiguration];
}

-(void)lightToggle{
    if(self.isLightOn)
        [self light:NO];
    else
        [self light:YES];
}

-(void)light:(BOOL)yesno{

    if(![_backCameraDevice hasTorch])
        return;

    //      フロントカメラ使用中ならバックカメラに切り替え
    if(self.isUsingFrontCamera){
        [self useFrontCamera:NO];
    }
    
    NSError* error;
    [_backCameraDevice lockForConfiguration:&error];
    if(yesno == YES)
        _backCameraDevice.torchMode = AVCaptureTorchModeOn;
    else
      _backCameraDevice.torchMode = AVCaptureTorchModeOff;
    
    [_backCameraDevice unlockForConfiguration];
    
}
-(BOOL)isLightOn{

    
    if(![_backCameraDevice hasTorch])
        return NO;
    
    if(_backCameraDevice.isTorchActive)
        return YES;
    
    return NO;
}

#pragma mark - フォーカス制御

- (void) autoFocusAtPoint:(CGPoint)point
{
    AVCaptureDevice *device = videoInput.device;
    if ([device isFocusPointOfInterestSupported] && [device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            [device setFocusPointOfInterest:point];
            [device setFocusMode:AVCaptureFocusModeAutoFocus];
            [device unlockForConfiguration];
        }    }
}


- (void) continuousFocusAtPoint:(CGPoint)point
{
    AVCaptureDevice *device = videoInput.device;
	
    if ([device isFocusPointOfInterestSupported] && [device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
		NSError *error;
		if ([device lockForConfiguration:&error]) {
			[device setFocusPointOfInterest:point];
			[device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
			[device unlockForConfiguration];
		} 
	}
}

#pragma  mark - 初期化

//      デフォルト初期化
-(id)init
{
    self = [super init];
    if(self){
        _rawNSDataCache = [NSMutableArray array];
        
        if(SYSTEM_VERSION_LESS_THAN(@"7.0")){
#define IS_IOS6
        }
#ifdef IS_IOS6
        [self setupAVCapture:AVCaptureSessionPresetHigh];
#else
        [self setupAVCapture:AVCaptureSessionPresetInputPriority];
#endif
        return self;
    }
return nil;
}





//      解像度指定して初期化
-(id)initWithPreset:(NSString*)preset{

    if(super.init){
    
        _rawNSDataCache = [NSMutableArray array];
        [self setupAVCapture:preset];
        
        return self;
    }
    
    return nil;
}

//      プレビューレイヤをビューに設定する
-(void)setPreview:(UIView*)view{

    _previewLayer.frame = view.bounds;
    [view.layer addSublayer:_previewLayer];
    
}


#pragma mark convert

- (void)addPixelDataObject:(NSData *)data
{
    [_rawNSDataCache addObject:data];
    [self popCacheAndConvert];
}

- (void)popCacheAndConvert
{
    if (self.processingToConvert) {
        return;
    }
    if ([self.rawNSDataCache count] == 0) {
        return;
    }
    self.processingToConvert = YES;
    __block LmCmCameraManager* _self = self;
    
    
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(q_global, ^{
        LOG(@"count: %d", (int)[_self.rawNSDataCache count]);
        LmCmPixelData* data = (LmCmPixelData*)[_self.rawNSDataCache objectAtIndex:0];
        LmCmImageAsset* asset = [[LmCmImageAsset alloc] init];
        @autoreleasepool {
            CVPixelBufferRef imageBuffer = (CVPixelBufferRef)[data.pixelData bytes];
            
            CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
            
            void* baseAddress = imageBuffer;
            CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, baseAddress, data.bufferSize, NULL);
            CGImageRef cgImage = CGImageCreate(data.width, data.height, 8, 32, data.bytesPerRow, colorspace, kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrder32Little, dataProvider, NULL, TRUE, kCGRenderingIntentDefault);
            CGDataProviderRelease(dataProvider);
            UIImage* image = [UIImage imageWithCGImage:cgImage];
            [LmCurrentImage writeTmpImage:image];
            CGImageRelease(cgImage);
            CGColorSpaceRelease(colorspace);
        }
        asset.orientation = data.orientation;
        asset.image = [LmCurrentImage tmpImage];
        asset.zoom = data.zoom;
        asset.cropSize = data.cropSize;
        
        [_self.delegate singleImageNoSoundDidTakeWithAsset:asset];
        [_self.rawNSDataCache removeObjectAtIndex:0];
        _self.processingToConvert = NO;
        [_self performSelector:@selector(popCacheAndConvert) withObject:nil afterDelay:0.01];
    });
    
    return;
}


//
- (void)setupAVCapture:(NSString*)preset{
    
    /////////////////////////////////////////////////
    //    カメラの一覧を取得しカメラデバイスを保存
    /////////////////////////////////////////////////
    self.backCameraDevice = nil;
    self.frontCameraDevice = nil;
    
    AVCaptureDeviceFormat *bestFormat = nil;
    AVFrameRateRange *bestFrameRateRange = nil;
    
    NSArray*    cameraArray = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for(AVCaptureDevice *camera in cameraArray){
        if(camera.position == AVCaptureDevicePositionBack){
            self.backCameraDevice = camera;
            if ([camera lockForConfiguration:nil]) {
                for ( AVCaptureDeviceFormat *format in [camera formats] ) {
                    for ( AVFrameRateRange *range in format.videoSupportedFrameRateRanges ) {
                        if ( range.maxFrameRate > bestFrameRateRange.maxFrameRate ) {
                            bestFormat = format;
                            bestFrameRateRange = range;
                        }
                    }
                    bestFormat = format;
                }
                bestFormat = [[camera formats] objectAtIndex:[[camera formats] count] - 1];
                LOG(@"%@", bestFormat);
                if (bestFormat) {
                    camera.activeFormat = bestFormat;
                    //[camera setActiveVideoMinFrameDuration:bestFrameRateRange.minFrameDuration];
                    //[camera setActiveVideoMaxFrameDuration:bestFrameRateRange.maxFrameDuration];
                    if ([UIDevice isIOS6]) {
                        
                    }else{
                        [camera setActiveVideoMinFrameDuration:CMTimeMake(1, 5)];
                        [camera setActiveVideoMaxFrameDuration:CMTimeMake(1, 5)];
                    }
                    [camera unlockForConfiguration];
                }
            }
        }
        if(camera.position == AVCaptureDevicePositionFront)
            self.frontCameraDevice = camera;
    }
    
    //      デフォルトはバックカメラ
    videoInput = [AVCaptureDeviceInput deviceInputWithDevice:self.backCameraDevice error:nil];
    
    /////////////////////////////////////////////////
    //      キャプチャセッションの作成
    /////////////////////////////////////////////////
	captureSession = AVCaptureSession.new;
    [captureSession setSessionPreset:preset];
    [captureSession addInput:videoInput];
    
  	self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:captureSession];
	[self.previewLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    
    [self setupImageCapture];
    [self setupVideoCapture];
    
    
    [captureSession startRunning];
}

/////////////////////////////////////////////////
//      静止画キャプチャの初期化
//      設定後:captureOutputが呼ばれる
/////////////////////////////////////////////////
-(BOOL)setupImageCapture{
    
    imageOutput = AVCaptureStillImageOutput.new;
    if(imageOutput){
        if([captureSession canAddOutput:imageOutput]){
            [captureSession addOutput:imageOutput];
            return YES;
        }
    }
    
    return NO;
}

/////////////////////////////////////////////////
//      ビデオキャプチャの初期化
//      設定後:captureOutputが呼ばれる
/////////////////////////////////////////////////
-(BOOL)setupVideoCapture{
    
    
    //////////////////////////////////
    //    ビデオ出力デバイスの設定
    //////////////////////////////////
	NSDictionary *rgbOutputSettings = @{(id)kCVPixelBufferPixelFormatTypeKey: @(kCMPixelFormat_32BGRA)};
    videoOutput = AVCaptureVideoDataOutput.new;
	[videoOutput setVideoSettings:rgbOutputSettings];
	[videoOutput setAlwaysDiscardsLateVideoFrames:YES];     //  NOだとコマ落ちしないが重い処理には向かない
    
  	videoOutputQueue = dispatch_queue_create("VideoData Output Queue", DISPATCH_QUEUE_SERIAL);
	[videoOutput setSampleBufferDelegate:self queue:videoOutputQueue];
    
	if(videoOutput){
        if ([captureSession canAddOutput:videoOutput]){
            [captureSession addOutput:videoOutput];
            return YES;
        }
    }
    return NO;
}

///////////////////////////////////////////
//      オーディオキャプチャの初期化
//      設定後:captureOutputが呼ばれる
///////////////////////////////////////////
-(BOOL)setupAudioCapture{
    
    audioOutput = AVCaptureAudioDataOutput.new;
    audioOutputQueue = dispatch_queue_create("Audio Capture Queue", DISPATCH_QUEUE_SERIAL);
	[audioOutput setSampleBufferDelegate:self queue:audioOutputQueue];
    if(audioOutput){
        
        if ([captureSession canAddOutput:audioOutput]){
            [captureSession addOutput:audioOutput];
            return YES;
        }
    }
    return NO;
}



#pragma  mark - 撮影
//      写真撮影
-(void)takePhoto:(takePhotoBlock) block
{

    
    AVCaptureConnection* connection = [imageOutput connectionWithMediaType:AVMediaTypeVideo];
    
    //      画像の向きを調整する
    if(connection.isVideoOrientationSupported){
        connection.videoOrientation = UIDevice.currentDevice.orientation;
    }
    
    
    //      UIImage化した画像を通知する
    [imageOutput captureStillImageAsynchronouslyFromConnection:connection
                                                  completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
                                                      
                                                      if(imageDataSampleBuffer == nil){
                                                          block(nil,error);
                                                          return;
                                                      }
                                                      
                                                      NSData *data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                                                      UIImage *image = [UIImage imageWithData:data];
                                        
                                                      
                                                      block(image,error);

                                                  }];

    
}
 //  デバイスの向きに合わせたビデオイメージを作成
-(UIImage*)rotatedVideoImage{

    if(self.videoImage == nil)
        return nil;
    

    UIImage* image = nil;
    UIDeviceOrientation orientation = _videoOrientaion;
    BOOL isMirrored = self.isUsingFrontCamera;
    
    if (orientation == UIDeviceOrientationPortrait) {
        image = [LmCmCameraManager rotateImage:self.videoImage angle:270];
    } else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
            image = [LmCmCameraManager rotateImage:self.videoImage angle:90];
    } else if (orientation == UIDeviceOrientationLandscapeRight) {
        if(isMirrored)
            image = self.videoImage;
        else
            image = [LmCmCameraManager rotateImage:self.videoImage angle:180];
    }else {
        if(isMirrored)
            image = [LmCmCameraManager rotateImage:self.videoImage angle:180];
        else
            image = self.videoImage;
    }
    
    return image;
}
+ (UIImage*)rotateImage:(UIImage*)img angle:(int)angle
{
    CGImageRef      imgRef = [img CGImage];
    CGContextRef    context;
    
    switch (angle) {
        case 90:
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(img.size.height, img.size.width), YES, img.scale);
            context = UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(context, img.size.height, img.size.width);
            CGContextScaleCTM(context, 1, -1);
            CGContextRotateCTM(context, M_PI_2);
            break;
        case 180:
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(img.size.width, img.size.height), YES, img.scale);
            context = UIGraphicsGetCurrentContext();
            CGContextTranslateCTM(context, img.size.width, 0);
            CGContextScaleCTM(context, 1, -1);
            CGContextRotateCTM(context, -M_PI);
            break;
        case 270:
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(img.size.height, img.size.width), YES, img.scale);
            context = UIGraphicsGetCurrentContext();
            CGContextScaleCTM(context, 1, -1);
            CGContextRotateCTM(context, -M_PI_2);
            break;
        default:
            return img;
            break;
    }
    
    CGContextDrawImage(context, CGRectMake(0, 0, img.size.width, img.size.height), imgRef);
    UIImage*    result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

/////////////////////////////////////////////////////////////////////////////////
//      ビデオキャプチャ時、 新しいフレームが書き込まれた際に通知を受けるデリゲートメソッド
/////////////////////////////////////////////////////////////////////////////////
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
        if (_currentCapturedNumber < _allCaptureNumber) {
            
            AVCaptureDevice* device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            if (device.adjustingFocus) {
                LOG(@"Sorry adjusting focus.");
                return;
            }
            
            _currentCapturedNumber++;
            
            CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
            CVPixelBufferLockBaseAddress(imageBuffer,0);
            
            size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
            size_t width = CVPixelBufferGetWidth(imageBuffer);
            size_t height = CVPixelBufferGetHeight(imageBuffer);
            void *src_buff = CVPixelBufferGetBaseAddress(imageBuffer);
            
            LmCmPixelData* data = [[LmCmPixelData alloc] init];
            data.width = width;
            data.height = height;
            data.bytesPerRow = bytesPerRow;
            data.bufferSize = CVPixelBufferGetDataSize(imageBuffer);
            data.orientation = [MotionOrientation sharedInstance].deviceOrientation;
            data.pixelData = [NSData dataWithBytes:src_buff length:bytesPerRow * height];
            CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
            
            LmCmSharedCamera* camera = [LmCmSharedCamera instance];
            data.zoom = camera.zoom;
            data.cropSize = camera.cropSize;
            
            [self addPixelDataObject:data];
            
            /*
            CGImageRef cgImage = [CameraManager imageFromSampleBuffer:sampleBuffer];
            UIImage* captureImage = [UIImage imageWithCGImage:cgImage];
            CGImageRelease(cgImage);
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [_self.delegate singleImageCaptured:captureImage withOrientation:[MotionOrientation sharedInstance].deviceOrientation];
            });
             */
        }else{
            CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
            [[LmLivePreview instance] processNewCameraFrame:imageBuffer];
        }
        
        /*
        return;
        ////////////////////////////////////////////
        //      メインスレッドでの処理
        ////////////////////////////////////////////
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            self.videoImage = captureImage;
            self.videoOrientaion = UIDevice.currentDevice.orientation;
 
            //      デリゲートの存在確認後画面更新
            if ([self.delegate respondsToSelector:@selector(videoFrameUpdate:from:)]) {
                [self.delegate videoFrameUpdate:self.videoImage.CGImage from:self];
            }
        });
         
         */

}


#pragma mark - ユーティリティ

- (NSUInteger) cameraCount
{
    return [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
}

- (NSUInteger) micCount
{
    return [[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio] count];
}

- (AVCaptureDevice *) cameraWithPosition:(AVCaptureDevicePosition) position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}

- (AVCaptureDevice *) frontFacingCamera
{
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

- (AVCaptureDevice *) backFacingCamera
{
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

- (AVCaptureDevice *) audioDevice
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio];
    if ([devices count] > 0) {
        return [devices objectAtIndex:0];
    }
    return nil;
}

#pragma mark Shooting

- (void)takeOnePicture
{
    if ([LmCmSharedCamera instance].soundEnabled) {
        [self takeOnePicutreByNormalCamera];
        return;
    }
    [self takeOnePicutreWithNoSound];
}

- (void)takeOnePicutreWithNoSound
{
    _processingToConvert = NO;
    _allCaptureNumber = 1;
    _currentCapturedNumber = 0;
}

- (void)takeOnePicutreByNormalCamera
{
    AVCaptureConnection* connection = [imageOutput connectionWithMediaType:AVMediaTypeVideo];
    
    //      画像の向きを調整する
    if(connection.isVideoOrientationSupported){
        connection.videoOrientation = UIDevice.currentDevice.orientation;
    }
    
    //      UIImage化した画像を通知する
    [imageOutput captureStillImageAsynchronouslyFromConnection:connection
                                             completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
                                                 if(imageDataSampleBuffer == nil){
                                                     return;
                                                 }
                                                 
                                                 UIImage* image;
                                                 NSData *data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                                                 image = [[UIImage alloc] initWithData:data];
                                                 
                                                 
                                                 LmCmSharedCamera* camera = [LmCmSharedCamera instance];
                                                 LmCmImageAsset* asset = [[LmCmImageAsset alloc] init];
                                                 asset.image = image;
                                                 asset.zoom = camera.zoom;
                                                 asset.cropSize = camera.cropSize;
                                                 asset.orientation = [MotionOrientation sharedInstance].deviceOrientation;
                                                 [self.delegate singleImageByNormalCameraDidTakeWithAsset:asset];
                                                 
                                             }];
    

}

#pragma mark - クラス・メソッド


//////////////////////////////////////////////////////
//      SampleBufferをCGImageRefに変換する
//////////////////////////////////////////////////////
+ (CGImageRef) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer,0);        //      バッファをロック
    
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef newContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef newImage = CGBitmapContextCreateImage(newContext);
    CGContextRelease(newContext);
    
    CGColorSpaceRelease(colorSpace);
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);      //      バッファをアンロック

    return newImage;
}


@end

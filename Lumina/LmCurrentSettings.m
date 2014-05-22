//
//  LmCurrentSettings.m
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCurrentSettings.h"

@implementation LmCurrentSettings

static LmCurrentSettings* sharedLmCurrentSettings = nil;

+ (LmCurrentSettings*)instance {
	@synchronized(self) {
		if (sharedLmCurrentSettings == nil) {
			sharedLmCurrentSettings = [[self alloc] init];
		}
	}
	return sharedLmCurrentSettings;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedLmCurrentSettings == nil) {
			sharedLmCurrentSettings = [super allocWithZone:zone];
			return sharedLmCurrentSettings;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark ui

+ (float)topBarHeight
{
    return 50.0f;
}

+ (float)bottomBarHeight
{
    return 88.0f;
}

+ (CGRect)shutterButtonRect
{
    return CGRectMake(0.0f, 0.0f, 70.0f, 70.0f);
}
@end

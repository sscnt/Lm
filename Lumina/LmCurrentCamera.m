//
//  LmCurrentCamera.m
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "LmCurrentCamera.h"

@implementation LmCurrentCamera

static LmCurrentCamera* sharedLmCurrentCamera = nil;

+ (LmCurrentCamera*)instance {
	@synchronized(self) {
		if (sharedLmCurrentCamera == nil) {
			sharedLmCurrentCamera = [[self alloc] init];
		}
	}
	return sharedLmCurrentCamera;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedLmCurrentCamera == nil) {
			sharedLmCurrentCamera = [super allocWithZone:zone];
			return sharedLmCurrentCamera;
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
        [self reset];
    }
    return self;
}

+ (void)reset
{
    [[LmCurrentCamera instance] reset];
}

- (void)reset
{
    
}


@end

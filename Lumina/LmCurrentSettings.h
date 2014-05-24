//
//  LmCurrentSettings.h
//  Lumina
//
//  Created by SSC on 2014/05/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LmCurrentSettingsTheme){
    LmCurrentSettingsThemeDefault = 1,
};

@interface LmCurrentSettings : NSObject

+ (LmCurrentSettings*)instance;

@end

//
//  MDTestUtil.h
//  MDResourceManager
//
//  Created by Joao Prudencio on 22/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDTestUtil : NSObject

+ (void)mockDeviceModel:(NSString *)deviceModel isIpad:(BOOL)isIpad;
+ (void)mockDeviceOrientationIsPortrait:(BOOL)isPortrait;

@end
//
//  MDDeviceUtil.h
//  Pods
//
//  Created by Joao Prudencio on 22/02/15.
//
//

#import <Foundation/Foundation.h>

@interface MDDeviceUtil : NSObject

+ (BOOL)isDevicePortrait;
+ (BOOL)isDevicePad;
+ (NSString *)deviceVersion;

@end
//
//  MDTestUtil.m
//  MDResourceManager
//
//  Created by Joao Prudencio on 22/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import "MDTestUtil.h"
#import "MDDeviceUtil.h"
#import "OCMock.h"

@implementation MDTestUtil

+ (void)mockDeviceModel:(NSString *)deviceModel isIpad:(BOOL)isIpad {
    
    id deviceUtilMock = OCMClassMock([MDDeviceUtil class]);
    OCMStub([deviceUtilMock isDevicePad]).andReturn(isIpad);
    OCMStub([deviceUtilMock deviceVersion]).andReturn(deviceModel);
}

+ (void)mockDeviceOrientationIsPortrait:(BOOL)isPortrait {
    
    id deviceUtilMock = OCMClassMock([MDDeviceUtil class]);
    OCMStub([deviceUtilMock isDevicePortrait]).andReturn(isPortrait);
}

@end
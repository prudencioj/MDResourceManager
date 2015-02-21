//
//  MDAppDelegate.m
//  MDResourceManager
//
//  Created by CocoaPods on 02/20/2015.
//  Copyright (c) 2014 Joao Prudencio. All rights reserved.
//

#import "MDAppDelegate.h"
#import "MDDeviceResourceCriteria.h"
#import "MDOrientationResourceCriteria.h"

@implementation MDAppDelegate

static MDAppDelegate * _sharedInstance = nil;

+ (instancetype)sharedInstance {
    return _sharedInstance;
}
    
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _sharedInstance = self;

    NSArray *criterias = @[[[MDDeviceResourceCriteria alloc] init],
                            [[MDOrientationResourceCriteria alloc] init]];
    
    self.resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"dimensions"
                                                                   criterias:criterias];
    
    [self.resourceManager loadResources];
    
    return YES;
}

@end
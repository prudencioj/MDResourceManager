//
//  MDAppDelegate.m
//  MDResourceManager
//
//  Created by CocoaPods on 02/20/2015.
//  Copyright (c) 2014 Joao Prudencio. All rights reserved.
//

#import "MDAppDelegate.h"

@implementation MDAppDelegate

static MDAppDelegate * _sharedInstance = nil;

+ (instancetype)sharedInstance {
    return _sharedInstance;
}
    
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _sharedInstance = self;

    self.resourceManager = [[MDResourceManager alloc] init];
    
    return YES;
}

@end
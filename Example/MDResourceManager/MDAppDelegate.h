//
//  MDAppDelegate.h
//  MDResourceManager
//
//  Created by CocoaPods on 02/20/2015.
//  Copyright (c) 2014 Joao Prudencio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDResourceManager.h"

@interface MDAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) MDResourceManager *resourceManager;

+ (instancetype)sharedInstance;

@end

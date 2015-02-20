//
//  OrientationRule.m
//  resources
//
//  Created by Joao Prudencio on 20/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import "MDOrientationRule.h"

@implementation MDOrientationRule

- (instancetype)initWithPortrait:(BOOL)isPortrait {

    self = [super init];
    
    if (self) {
        
        _isPortrait = isPortrait;
    }
    return self;
}

- (BOOL)doesRuleMatch {
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    BOOL isDevicePortrait = UIDeviceOrientationIsPortrait(interfaceOrientation);
    
    return isDevicePortrait == self.isPortrait;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@",self.isPortrait? @"Portrait": @"Landscape"];
}

@end
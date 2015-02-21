//
//  Rule.m
//  resources
//
//  Created by Joao Prudencio on 20/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import "MDAbstractRule.h"
#import "MDSmallestWidthRule.h"
#import "MDOrientationRule.h"
#import "MDDeviceRule.h"
#import "MDScreenSizeRule.h"

@implementation MDAbstractRule

+ (NSArray *)priorityRulesClasses {
    
    static NSArray *rulesClasses;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        rulesClasses = @[[MDDeviceRule class],
                         [MDOrientationRule class]
                         ];
    });
    
    return rulesClasses;
}

- (BOOL)doesRuleMatch {
    
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    
    return NO;
}

- (NSComparisonResult)compare:(MDAbstractRule *)rule {
    
    return NSOrderedAscending;
}

@end
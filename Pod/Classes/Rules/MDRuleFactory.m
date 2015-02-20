//
//  RuleFactory.m
//  resources
//
//  Created by Joao Prudencio on 20/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import "MDRuleFactory.h"
#import "MDSmallestWidthRule.h"
#import "MDOrientationRule.h"

static NSString *const kQualifierPrefixSmallestWidth = @"sw";
static NSString *const kQualifierPrefixLandscape = @"land";
static NSString *const kQualifierPrefixPortrait = @"port";

@implementation MDRuleFactory

+ (MDAbstractRule *)makeRuleWithQualifier:(NSString *)qualifier {

    if ([qualifier hasPrefix:kQualifierPrefixSmallestWidth]) {
        
        return [self makeSmallestWidthRule:qualifier];
    } else if ([qualifier hasPrefix:kQualifierPrefixLandscape] ||
               [qualifier hasPrefix:kQualifierPrefixPortrait]){
        
        return [self makeOrientationRule:qualifier];
    } else {
        
        NSAssert(YES, @"Cannot build rule, invalid qualifier name: %@",qualifier);
    }
    
    return nil;
}

#pragma mark - SmallestWidthRule

+ (MDSmallestWidthRule *)makeSmallestWidthRule:(NSString *)qualifier {
    
    NSString *valueString = [qualifier substringFromIndex:2];
    
    // TODO validate number
    
    MDSmallestWidthRule * smallestWidthRule = [[MDSmallestWidthRule alloc] initWithValue:valueString.floatValue];
    
    return smallestWidthRule;
}

#pragma mark - OrientationRule

+ (MDOrientationRule *)makeOrientationRule:(NSString *)qualifier {
    
    BOOL isPortrait = [qualifier hasPrefix:kQualifierPrefixPortrait];
    MDOrientationRule *orientationRule = [[MDOrientationRule alloc] initWithPortrait:isPortrait];
    
    return orientationRule;
}

@end
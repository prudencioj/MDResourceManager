//
//  MDOrientationResourceCriteria.m
//  Pods
//
//  Created by Joao Prudencio on 21/02/15.
//
//

#import "MDOrientationResourceCriteria.h"
#import <UIKit/UIKit.h>
#import "MDDeviceUtil.h"

static NSString *const kQualifierPrefixLandscape = @"land";
static NSString *const kQualifierPrefixPortrait = @"port";

@implementation MDOrientationResourceCriteria

#pragma mark - MDResourceCriteriaProtocol

- (BOOL)meetCriteriaWith:(NSString *)qualifier {
    
    NSString *lowerCaseQualifier = [qualifier lowercaseString];

    if (![self respondsToQualifier:qualifier]) {
        
        return NO;
    }
    
    BOOL isQualifierPortrait = [lowerCaseQualifier hasPrefix:kQualifierPrefixPortrait];
    
    return MDDeviceUtil.isDevicePortrait == isQualifierPortrait;
}

- (BOOL)respondsToQualifier:(NSString *)qualifier {
    
    NSString *lowerCaseQualifier = [qualifier lowercaseString];
    return [lowerCaseQualifier hasPrefix:kQualifierPrefixLandscape] ||
           [lowerCaseQualifier hasPrefix:kQualifierPrefixPortrait];
}

- (BOOL)shouldOverrideQualifier:(NSString *)qualifier1 withQualifier:(NSString *)qualifier2 {
    
    return NO;
}

@end
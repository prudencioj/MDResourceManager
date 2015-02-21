//
//  MDOrientationResourceCriteria.m
//  Pods
//
//  Created by Joao Prudencio on 21/02/15.
//
//

#import "MDOrientationResourceCriteria.h"
#import <UIKit/UIKit.h>

static NSString *const kQualifierPrefixLandscape = @"land";
static NSString *const kQualifierPrefixPortrait = @"port";

@implementation MDOrientationResourceCriteria

#pragma mark - MDResourceCriteriaProtocol

- (BOOL)meetCriteriaWith:(NSString *)qualifier {
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    BOOL isDevicePortrait = UIDeviceOrientationIsPortrait(interfaceOrientation);
    
    BOOL isQualifierPortrait = [qualifier hasPrefix:kQualifierPrefixPortrait];
    
    return isDevicePortrait == isQualifierPortrait;
}

- (BOOL)respondsToQualifier:(NSString *)qualifier {
    
    return [qualifier hasPrefix:kQualifierPrefixLandscape] ||
           [qualifier hasPrefix:kQualifierPrefixPortrait];
}

- (BOOL)shouldOverrideQualifier:(NSString *)qualifier1 withQualifier:(NSString *)qualifier2 {
    
    return NO;
}

@end
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

- (instancetype)initWithInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {

    self = [super init];
    
    if (self) {
        
        _interfaceOrientation = interfaceOrientation;
    }
    
    return self;
}

#pragma mark - MDResourceCriteriaProtocol

- (BOOL)meetCriteriaWith:(NSString *)qualifier {
    
    NSString *lowerCaseQualifier = [qualifier lowercaseString];

    if (![self respondsToQualifier:qualifier]) {
        
        return NO;
    }
    
    BOOL isQualifierPortrait = [lowerCaseQualifier hasPrefix:kQualifierPrefixPortrait];
    
    return [self isDevicePortrait] == isQualifierPortrait;
}

- (BOOL)respondsToQualifier:(NSString *)qualifier {
    
    NSString *lowerCaseQualifier = [qualifier lowercaseString];
    return [lowerCaseQualifier hasPrefix:kQualifierPrefixLandscape] ||
           [lowerCaseQualifier hasPrefix:kQualifierPrefixPortrait];
}

- (BOOL)shouldOverrideQualifier:(NSString *)qualifier1 withQualifier:(NSString *)qualifier2 {
    
    return NO;
}

- (BOOL)criteriaChangesInRuntime {
    
    return YES;
}

#pragma mark - 

- (BOOL)isDevicePortrait {
    
    return self.interfaceOrientation != UIInterfaceOrientationUnknown? UIDeviceOrientationIsPortrait(self.interfaceOrientation): MDDeviceUtil.isDevicePortrait;
}

@end
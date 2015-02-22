//
//  MDDeviceResourceCriteria.m
//  Pods
//
//  Created by Joao Prudencio on 21/02/15.
//
//

#import "MDDeviceResourceCriteria.h"
#import <UIKit/UIKit.h>
#import "MDDeviceUtil.h"

static NSString *const kQualifierPrefixIphone = @"iphone";
static NSString *const kQualifierPrefixIpad = @"ipad";

@implementation MDDeviceResourceCriteria

#pragma mark - MDResourceCriteriaProtocol

- (BOOL)meetCriteriaWith:(NSString *)qualifier {
    
    BOOL isPad = [qualifier isEqualToString:kQualifierPrefixIpad];
    BOOL isEqualDevice = isPad == MDDeviceUtil.isDevicePad;
    
    NSString *model = [self modelFromDevice:qualifier];
    
    BOOL isEqualModel = model && model.length > 0? [[self currentModel] containsString:model]: YES;
    
    return isEqualDevice && isEqualModel;
}

- (BOOL)respondsToQualifier:(NSString *)qualifier {
    
    return [qualifier hasPrefix:kQualifierPrefixIphone] ||
           [qualifier hasPrefix:kQualifierPrefixIpad];
}

- (BOOL)shouldOverrideQualifier:(NSString *)qualifier1 withQualifier:(NSString *)qualifier2 {
    
    NSString *model1 = [self modelFromDevice:qualifier1];
    NSString *model2 = [self modelFromDevice:qualifier2];

    BOOL hasModel1 = model1 && model1.length > 0;
    BOOL hasModel2 = model2 && model2.length > 0;
    
    if (!hasModel1 && hasModel2) {
        
        return YES;
    } else if (hasModel1 && hasModel2 && model1.length > model1.length) {
        
        return YES;
    } else {
        
        return NO;
    }
}

#pragma mark - Helper

- (NSString *)currentModel {
    
    return [self modelFromDevice:[MDDeviceUtil deviceVersion]];
}

- (NSString *)modelFromDevice:(NSString *)device {
    
    NSString *deviceDescription = @"";
    
    if ([device hasPrefix:kQualifierPrefixIpad]) {
        
        deviceDescription = [device substringToIndex:kQualifierPrefixIpad.length];
    } else {
        
        deviceDescription = [device substringToIndex:kQualifierPrefixIphone.length];
    }
    
    if ([deviceDescription isEqualToString:device]) {
        
        return @"";
    } else {
        
        return [device substringFromIndex:deviceDescription.length];
    }
}

@end
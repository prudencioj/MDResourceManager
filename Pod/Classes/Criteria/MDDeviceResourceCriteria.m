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
    
    NSString *lowerCaseQualifier = [qualifier lowercaseString];

    // to meet the criteria the qualifier must represent the same device.
    // if the qualifier has no specific model the criteria meets.
    // e.g. device = iphone6plus qualifier = iphone -> YES
    //      device = iphone6plus qualifier = iphone6 -> YES
    //      device = iphone6plus qualifier = iphone6plus -> YES
    //      device = iphone6plus qualifier = iphone5 -> NO

    BOOL isPad = [lowerCaseQualifier isEqualToString:kQualifierPrefixIpad];
    BOOL isEqualDevice = isPad == MDDeviceUtil.isDevicePad;
    
    NSString *currentModel = [self modelFromDevice:lowerCaseQualifier];
    NSString *deviceModel = [self currentModel].copy;
    
    BOOL containsModel = [deviceModel rangeOfString:currentModel].length > 0;
    
    BOOL isEqualModel = currentModel && currentModel.length > 0? containsModel: YES;
    
    return isEqualDevice && isEqualModel;
}

- (BOOL)respondsToQualifier:(NSString *)qualifier {
    
    NSString *lowerCaseQualifier = [qualifier lowercaseString];
    return [lowerCaseQualifier hasPrefix:kQualifierPrefixIphone] ||
           [lowerCaseQualifier hasPrefix:kQualifierPrefixIpad];
}

- (BOOL)shouldOverrideQualifier:(NSString *)qualifier1 withQualifier:(NSString *)qualifier2 {
    
    NSString *lowerCaseQualifier1 = [qualifier1 lowercaseString];
    NSString *lowerCaseQualifier2 = [qualifier2 lowercaseString];

    // choose the qualifier more specific
    // e.g. iphone6plus should override iphone6
    
    NSString *model1 = [self modelFromDevice:lowerCaseQualifier1];
    NSString *model2 = [self modelFromDevice:lowerCaseQualifier2];

    BOOL hasModel1 = model1 && model1.length > 0;
    BOOL hasModel2 = model2 && model2.length > 0;
    
    if (!hasModel1 && hasModel2) {
        
        return YES;
    } else if (hasModel1 && hasModel2 && model2.length > model1.length) {
        
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
    } else if ([device hasPrefix:kQualifierPrefixIphone]){
        
        deviceDescription = [device substringToIndex:kQualifierPrefixIphone.length];
    }
    
    if ([deviceDescription isEqualToString:device]) {
        
        return @"";
    } else {
        
        return [device substringFromIndex:deviceDescription.length];
    }
}

@end
//
//  MDDeviceResourceCriteria.m
//  Pods
//
//  Created by Joao Prudencio on 21/02/15.
//
//

#import "MDDeviceResourceCriteria.h"
#import <UIKit/UIKit.h>
#import <sys/utsname.h>

static NSString *const kQualifierPrefixIphone = @"iphone";
static NSString *const kQualifierPrefixIpad = @"ipad";

@implementation MDDeviceResourceCriteria

#pragma mark - MDResourceCriteriaProtocol

- (BOOL)meetCriteriaWith:(NSString *)qualifier {
    
    BOOL isPad = [qualifier isEqualToString:kQualifierPrefixIpad];
    BOOL isEqualDevice = isPad == self.isDevicePad;
    
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

- (BOOL)isDevicePad {
    
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
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

- (NSString *)currentModel {
    
    return [self modelFromDevice:[self deviceVersion]];
}

#pragma mark - UIDevice check

// FIXME use category

- (NSDictionary*)deviceNamesByCode {
    
    static NSDictionary* deviceNamesByCode = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        deviceNamesByCode = @{
                              //iPhones
                              @"iPhone3,1" :@"iphone4",
                              @"iPhone3,2" :@"iphone4",
                              @"iPhone3,3" :@"iphone4",
                              @"iPhone4,1" :@"iphone4s",
                              @"iPhone4,2" :@"iphone4s",
                              @"iPhone4,3" :@"iphone4s",
                              @"iPhone5,1" :@"iphone5",
                              @"iPhone5,2" :@"iphone5",
                              @"iPhone5,3" :@"iphone5c",
                              @"iPhone5,4" :@"iphone5c",
                              @"iPhone6,1" :@"iphone5s",
                              @"iPhone6,2" :@"iphone5s",
                              @"iPhone7,2" :@"iphone6",
                              @"iPhone7,1" :@"iphone6plus",
                              @"i386"      :@"iphone6plus",
                              @"x86_64"    :@"iphone6plus",
                              
                              //iPads
                              @"iPad1,1" :@"ipad1",
                              @"iPad2,1" :@"ipad2",
                              @"iPad2,2" :@"ipad2",
                              @"iPad2,3" :@"ipad2",
                              @"iPad2,4" :@"ipad2",
                              @"iPad2,5" :@"ipadmini",
                              @"iPad2,6" :@"ipadmini",
                              @"iPad2,7" :@"ipadmini",
                              @"iPad3,1" :@"ipad3",
                              @"iPad3,2" :@"ipad3",
                              @"iPad3,3" :@"ipad3",
                              @"iPad3,4" :@"ipad4",
                              @"iPad3,5" :@"ipad4",
                              @"iPad3,6" :@"ipad4",
                              @"iPad4,1" :@"ipadair",
                              @"iPad4,2" :@"ipadair",
                              @"iPad4,3" :@"ipadair",
                              @"iPad4,4" :@"ipadmini2",
                              @"iPad4,5" :@"ipadmini2",
                              @"iPad4,6" :@"ipadmini2",
                              @"iPad4,7" :@"ipadmini3",
                              @"iPad4,8" :@"ipadmini3",
                              @"iPad4,9" :@"ipadmini3",
                              @"iPad5,3" :@"ipadair2",
                              @"iPad5,4" :@"ipadair2",
                              
                              };
    });
    
    return deviceNamesByCode;
}

- (NSString *)deviceVersion {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *code = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    return self.deviceNamesByCode[code];
}

@end
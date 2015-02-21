//
//  MDDeviceRule.m
//  Pods
//
//  Created by Joao Prudencio on 21/02/15.
//
//

#import "MDDeviceRule.h"
#import <sys/utsname.h>

static NSString *const kQualifierPrefixIphone = @"iphone";
static NSString *const kQualifierPrefixIpad = @"ipad";

@implementation MDDeviceRule

- (instancetype)initWithDevice:(NSString *)device {
    
    self = [super init];
    
    if (self) {
        
        _device = device;
        _model = [self modelFromDevice:device];
    }
    
    return self;
}

- (BOOL)doesRuleMatch {
    
    BOOL isPad = [self.device isEqualToString:kQualifierPrefixIpad];
    BOOL isEqualDevice = isPad == self.isDevicePad;

    
    BOOL isEqualModel = self.model && self.model.length > 0? [[self currentModel] containsString:self.model]: YES;
    
    return isEqualDevice && isEqualModel;
}

- (NSComparisonResult)compare:(MDAbstractRule *)rule {
    
    if ([rule isKindOfClass:[MDDeviceRule class]]) {
        
        MDDeviceRule *deviceRule = (MDDeviceRule *)rule;
        
        BOOL hasModel1 = self.model && self.model.length > 0;
        BOOL hasModel2 = deviceRule.model && deviceRule.model.length > 0;

        if (hasModel1 && !hasModel2) {
            
            return NSOrderedAscending;
        } else if (hasModel1 && hasModel2 && self.model.length > deviceRule.model.length) {
            
            return NSOrderedAscending;
        } else {
         
            return NSOrderedDescending;
        }
    }
    
    return NSOrderedDescending;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@",self.device];
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
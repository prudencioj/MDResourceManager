//
//  MDDeviceRule.m
//  Pods
//
//  Created by Joao Prudencio on 21/02/15.
//
//

#import "MDDeviceRule.h"

@implementation MDDeviceRule

- (instancetype)initWithDevice:(NSString *)device {
    
    self = [super init];
    
    if (self) {
        
        _device = device;
    }
    
    return self;
}
- (BOOL)doesRuleMatch {
    
    BOOL isPad = [self.device isEqualToString:@"ipad"];
    
    return isPad == self.isDevicePad;
}

- (BOOL)isDevicePad {
    
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@",self.isDevicePad? @"iPad": @"iPhone"];
}

@end
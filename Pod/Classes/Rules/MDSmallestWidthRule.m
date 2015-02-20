//
//  SmallestWidthRule.m
//  resources
//
//  Created by Joao Prudencio on 20/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import "MDSmallestWidthRule.h"

@interface MDSmallestWidthRule ()

@property (nonatomic, readonly) CGFloat deviceSmallestWidth;

@end

@implementation MDSmallestWidthRule

- (instancetype)initWithValue:(CGFloat)value {

    self = [super init];
    
    if (self) {
        
        _value = value;
    }
    
    return self;
}

- (BOOL)doesRuleMatch {
    
    return self.deviceSmallestWidth >= self.value;
}

- (NSComparisonResult)compare:(MDAbstractRule *)rule {
    
    if ([rule isKindOfClass:[MDSmallestWidthRule class]]) {
     
        MDSmallestWidthRule *smallestWidthRule = (MDSmallestWidthRule *)rule;
        
        CGFloat diff1 = ABS(self.deviceSmallestWidth - self.value);
        CGFloat diff2 = ABS(self.deviceSmallestWidth - smallestWidthRule.value);
        
        // TODO proper comparison
        
        return [@(diff2) compare:@(diff1)];
    }
    
    return [super compare:rule];
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%f",self.value];
}

#pragma mark - Private 

- (CGFloat)deviceSmallestWidth {
    
    CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    return MIN(height,width);
}

@end
//
//  Resource.m
//  resources
//
//  Created by Joao Prudencio on 20/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import "MDResource.h"

@implementation MDResource

- (instancetype)initWithValues:(NSDictionary *)values resourceQualifiers:(NSArray *)resourceQualifiers {

    self = [super init];
    
    if (self) {
        
        _values = values;
        _resourceQualifiers = resourceQualifiers;
    }
    
    return self;
}

- (BOOL)meetAllCriteriasForKey:(NSString *)key {

    // check if the value exists in this resource

    if (self.values[key]) {
        
        // if exists now check for its resource qualifiers
        // all qualifiers must meet its criteria
    
        __block BOOL meetsCriteria = YES;

        [self.resourceQualifiers enumerateObjectsUsingBlock:^(MDResourceQualifier *resourceQualifier, NSUInteger idx, BOOL *stop) {
            
            if (![resourceQualifier meetCriteria]) {
                
                meetsCriteria = NO;
                *stop = YES;
            }
        }];
        
        return meetsCriteria;
    } else {
        
        return NO;
    }
}

- (MDResourceQualifier *)resourceQualifierForCriteria:(id <MDResourceCriteriaProtocol>)criteria {
    
    for (MDResourceQualifier *resourceQualifier in self.resourceQualifiers) {
        
        // FIXME find a better way to do this
        if ([criteria respondsToQualifier:resourceQualifier.qualifier]) {
            
            return resourceQualifier;
        }
    }
    return nil;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"values: %@ rules:%@",self.values,self.resourceQualifiers];
}

@end
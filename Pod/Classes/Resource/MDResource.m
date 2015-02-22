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

- (NSString *)description {
    
    return [NSString stringWithFormat:@"values: %@ rules:%@",self.values,self.resourceQualifiers];
}

@end
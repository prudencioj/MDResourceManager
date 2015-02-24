//
//  Resource.m
//  resources
//
//  Created by Joao Prudencio on 20/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import "MDResource.h"

@implementation MDResource

- (instancetype)initWithFileName:(NSString *)fileName
                          values:(NSDictionary *)values
              resourceQualifiers:(NSArray *)resourceQualifiers {
 
    self = [super init];
    
    if (self) {
        
        _fileName = fileName;
        _values = values;
        _resourceQualifiers = resourceQualifiers;
    }
    
    return self;
}

- (instancetype)initWithValues:(NSDictionary *)values
            resourceQualifiers:(NSArray *)resourceQualifiers {
    
    self = [super init];
    
    if (self) {
        
        _values = values;
        _resourceQualifiers = resourceQualifiers;
    }
    
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"filename:%@ values:%@ rules:%@",self.fileName, self.values, self.resourceQualifiers];
}

@end
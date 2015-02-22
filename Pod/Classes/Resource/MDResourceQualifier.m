//
//  MDResourceQualifier.m
//  Pods
//
//  Created by Joao Prudencio on 21/02/15.
//
//

#import "MDResourceQualifier.h"

@implementation MDResourceQualifier

- (instancetype)initWithQualifier:(NSString *)qualifier criteriaClass:(Class)criteriaClass {
    
    self = [super init];
    
    if (self) {
        
        _qualifier = qualifier;
        _criteriaClass = criteriaClass;
    }
    
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"Criteria %@ with qualifier %@ ",self.criteriaClass,self.qualifier];
}

@end
//
//  MDResourceQualifier.m
//  Pods
//
//  Created by Joao Prudencio on 21/02/15.
//
//

#import "MDResourceQualifier.h"

@implementation MDResourceQualifier

- (instancetype)initWithQualifier:(NSString *)qualifier criteria:(id<MDResourceCriteriaProtocol>)criteria {
    
    self = [super init];
    
    if (self) {
        
        _qualifier = qualifier;
        _criteria = criteria;
    }
    
    return self;
}

- (BOOL)meetCriteria {

    return [self.criteria meetCriteriaWith:self.qualifier];
}

- (NSComparisonResult)compare:(MDResourceQualifier *)resourceQualifier {
    
    if ([self.criteria shouldOverrideQualifier:resourceQualifier.qualifier withQualifier:self.qualifier]) {
        
        return NSOrderedAscending;
    } else {
        
        return NSOrderedDescending;
    }
}

@end
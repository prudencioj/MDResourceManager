//
//  Resource.h
//  resources
//
//  Created by Joao Prudencio on 20/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDResourceQualifier.h"
#import "MDResourceCriteriaProtocol.h"

@interface MDResource : NSObject

@property (nonatomic, strong, readonly) NSDictionary *values;
@property (nonatomic, strong, readonly) NSArray *resourceQualifiers;

- (instancetype)initWithValues:(NSDictionary *)values resourceQualifiers:(NSArray *)resourceQualifiers;

- (BOOL)meetAllCriteriasForKey:(NSString *)key;
- (MDResourceQualifier *)resourceQualifierForCriteria:(id <MDResourceCriteriaProtocol>)criteria;

@end
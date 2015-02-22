//
//  Resource.h
//  resources
//
//  Created by Joao Prudencio on 20/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDResource : NSObject

@property (nonatomic, strong, readonly) NSDictionary *values;
@property (nonatomic, strong, readonly) NSArray *resourceQualifiers;

- (instancetype)initWithValues:(NSDictionary *)values resourceQualifiers:(NSArray *)resourceQualifiers;

@end
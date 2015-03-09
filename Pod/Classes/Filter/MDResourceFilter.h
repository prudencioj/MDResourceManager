//
//  ResourceFilter.h
//  resources
//
//  Created by Joao Prudencio on 20/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDResource.h"

@interface MDResourceFilter : NSObject

@property (nonatomic, strong) NSArray *criterias;

- (instancetype)initWithCriterias:(NSArray *)criterias;

- (MDResource *)filterResources:(NSArray *)resources forKey:(NSString *)key;

@end
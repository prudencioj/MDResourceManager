//
//  Rule.h
//  resources
//
//  Created by Joao Prudencio on 20/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDAbstractRule : NSObject

+ (NSArray *)priorityRulesClasses;

// Abstract methods to be overriden

- (BOOL)doesRuleMatch;
- (NSComparisonResult)compare:(MDAbstractRule *)rule;

@end
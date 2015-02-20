//
//  RuleFactory.h
//  resources
//
//  Created by Joao Prudencio on 20/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDAbstractRule.h"

@interface MDRuleFactory : NSObject

+ (MDAbstractRule *)makeRuleWithQualifier:(NSString *)qualifier;

@end
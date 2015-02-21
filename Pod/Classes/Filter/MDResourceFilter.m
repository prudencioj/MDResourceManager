//
//  ResourceFilter.m
//  resources
//
//  Created by Joao Prudencio on 20/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import "MDResourceFilter.h"
#import "MDAbstractRule.h"

@implementation MDResourceFilter

#pragma mark - Public

+ (MDResource *)filterResources:(NSArray *)resources forKey:(NSString *)key {
    
    // 1 Eliminate resource files that contradict the device configuration.
    NSArray *resourcesFiltered = [self filterContradictionResources:resources forKey:key];
    
    // Find best match
    NSArray *bestMatchResource = [self bestMatchInResource:resourcesFiltered.mutableCopy
                                         withPriorityRules:MDAbstractRule.priorityRulesClasses.mutableCopy
                                                    forKey:key];
    
    return bestMatchResource.firstObject;
}

#pragma mark - Private 

+ (NSArray *)filterContradictionResources:(NSArray *)resources forKey:(NSString *)key {
    
    NSMutableArray *filteredResources = @[].mutableCopy;
    
    [resources enumerateObjectsUsingBlock:^(MDResource *resource, NSUInteger idx, BOOL *stop) {
        
        // check if the value exists in this resource
        
        if (resource.values[key]) {
            
            // if exists now check for its rules
            // it must respect all the rules
            
            __block BOOL doesMatch = YES;
            [resource.rules enumerateObjectsUsingBlock:^(MDAbstractRule *rule, NSUInteger idx, BOOL *stop) {
                
                if (![rule doesRuleMatch]) {
                    
                    doesMatch = NO;
                    *stop = YES;
                }
            }];
            
            if (doesMatch) {
                
                [filteredResources addObject:resource];
            }
        }
    }];
    
    return [filteredResources copy];
}

+ (NSArray *)bestMatchInResource:(NSMutableArray *)resources
               withPriorityRules:(NSMutableArray *)priorityRules
                          forKey:(NSString *)key {
    
    // we should stop looking if only one resource is available
    // or priority rules are not available anymore
    
    if (resources.count == 1 ||
        priorityRules.count == 0) {
        
        return resources;
    }
    
    // 2. Pick the (next) highest-precedence qualifier in the list priorityRules.
    
    __block Class ruleClass = priorityRules.firstObject;
    
    // 3. Do any of the resource directories include this qualifier?

    __block MDResource *matchingResource = nil;
    __block MDAbstractRule *matchingRule = nil;
    __block NSMutableIndexSet *notMatchingIndexes = [[NSMutableIndexSet alloc] init];
    
    [resources enumerateObjectsUsingBlock:^(MDResource *resource, NSUInteger resourceIndex, BOOL *stop) {
        
        __block MDAbstractRule *foundRule = nil;
        if (resource.values[key]) {
            
            [resource.rules enumerateObjectsUsingBlock:^(MDAbstractRule *rule, NSUInteger ruleIndex, BOOL *stop) {
                
                if ([rule isKindOfClass:ruleClass]) {
                    
                    foundRule = rule;
                    *stop = YES;
                }
            }];
        }
        
        if ([foundRule doesRuleMatch]) {
            
            // There are cases where multiples resources exist with the same rule.
            // e.g. dimensions-sw200 and dimensions-sw300 in an iPhone6 device.
            // So both conditions are true, an iPhone6 has more than 200 and 300 points width.
            // In these cases we need choose the nearest one using the comparator of the Rule.
            // In this case we would choose dimensions-sw300
            
            if (!matchingRule || [foundRule compare:matchingRule] == NSOrderedAscending) {
            
                if (matchingResource) {
                    
                    NSUInteger indexMatching = [resources indexOfObject:matchingResource];
                    [notMatchingIndexes addIndex:indexMatching];
                }
                
                matchingRule = foundRule;
                matchingResource = resource;
            } else {
                
                [notMatchingIndexes addIndex:resourceIndex];
            }
        } else {
            
            [notMatchingIndexes addIndex:resourceIndex];
        }
        
    }];
    
    if (!matchingResource) {
        
        // If No resources match, return to step 2 and look at the next qualifier.
        
        if (priorityRules.count > 0) {
            
            [priorityRules removeObjectAtIndex:0];
        }
        
        return [self bestMatchInResource:resources
                       withPriorityRules:priorityRules
                                  forKey:key];
    }
    
    //  If resources matching were found, continue to step 4.

    // 4. Eliminate resource directories that do not include this qualifier.
    
    [resources removeObjectsAtIndexes:notMatchingIndexes];
    
    // 6. Go back and repeat until only one resource remains.
    
    if (priorityRules.count > 0) {
        
        [priorityRules removeObjectAtIndex:0];
    }
    
    return [self bestMatchInResource:resources
                   withPriorityRules:priorityRules
                              forKey:key];
}

@end
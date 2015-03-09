//
//  ResourceFilter.m
//  resources
//
//  Created by Joao Prudencio on 20/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import "MDResourceFilter.h"
#import "MDResourceCriteriaProtocol.h"

@interface MDResourceFilter ()

@end

@implementation MDResourceFilter

- (instancetype)initWithCriterias:(NSArray *)criterias {
    
    self = [super init];

    if (self) {
        
        _criterias = criterias;
    }
    return self;
}

#pragma mark - Public

- (MDResource *)filterResources:(NSArray *)resources
                         forKey:(NSString *)key {
    
    // Eliminate resource files that contradict the device configuration.
    NSArray *resourcesFiltered = [self filterContradictionResources:resources forKey:key];
    
    // Find best match
    NSArray *bestMatchResource = [self bestMatchInResource:resourcesFiltered.mutableCopy
                                         withResourceCriterias:self.criterias.mutableCopy
                                                    forKey:key];
    
    return bestMatchResource.firstObject;
}

#pragma mark - Private 

- (NSArray *)filterContradictionResources:(NSArray *)resources forKey:(NSString *)key {
    
    NSMutableArray *filteredResources = @[].mutableCopy;
    
    [resources enumerateObjectsUsingBlock:^(MDResource *resource, NSUInteger idx, BOOL *stop) {
        
        __block BOOL meetsAllCriterias = YES;
        
        if (resource.values[key]) {
            
            // if exists now check for its resource qualifiers
            // all qualifiers must meet its criteria
            
            [resource.resourceQualifiers enumerateObjectsUsingBlock:^(NSString *resourceQualifier, NSUInteger idx, BOOL *stop) {
                
                id<MDResourceCriteriaProtocol> criteria = [self findCriteriaForQualifier:resourceQualifier
                                                                         inCriteriasList:self.criterias];
                
                if (![criteria meetCriteriaWith:resourceQualifier]) {
                    
                    meetsAllCriterias = NO;
                    *stop = YES;
                }
            }];
            
        } else {
            
            meetsAllCriterias = NO;
        }

        
        if (meetsAllCriterias) {
            
            [filteredResources addObject:resource];
        }
    }];
    
    return [filteredResources copy];
}

- (NSArray *)bestMatchInResource:(NSMutableArray *)resources
           withResourceCriterias:(NSMutableArray *)resourceCriterias
                          forKey:(NSString *)key {
    
    // we should stop looking if only one resource is available
    // or resource criterias are not available anymore
    
    if (resources.count == 1 ||
        resourceCriterias.count == 0) {
        
        return resources;
    }
    
    // 2. Pick the (next) highest-precedence criteria in the list resourceCriterias.
    
    __block id<MDResourceCriteriaProtocol> resourceCriteria = resourceCriterias.firstObject;
    
    // 3. Do any of the resources have a qualifier for this criteria?

    __block MDResource *matchingResource = nil;
    __block NSString *matchingResourceQualifier = nil;
    __block NSMutableIndexSet *notMatchingIndexes = [[NSMutableIndexSet alloc] init];
    
    [resources enumerateObjectsUsingBlock:^(MDResource *resource, NSUInteger resourceIndex, BOOL *stop) {
        
        __block NSString *foundResourceQualifier = nil;
        
        if (resource.values[key]) {
            
            for (NSString *resourceQualifier in resource.resourceQualifiers) {
                
                if ([resourceCriteria respondsToQualifier:resourceQualifier]) {
                    
                    foundResourceQualifier = resourceQualifier;
                    break;
                }
            }
        }
        
        if (foundResourceQualifier &&
            [resourceCriteria meetCriteriaWith:foundResourceQualifier]) {
            
            // There are cases where multiples resources exist with the same rule.
            // e.g. dimensions-sw200 and dimensions-sw300 in an iPhone6 device.
            // So both conditions are true, an iPhone6 has more than 200 and 300 points width.
            // In these cases we need choose the nearest one using the comparator of the Rule.
            // In this case we would choose dimensions-sw300
            
            if (!matchingResourceQualifier ||
                [resourceCriteria shouldOverrideQualifier:matchingResourceQualifier
                                            withQualifier:foundResourceQualifier]) {
            
                if (matchingResourceQualifier) {
                    
                    NSUInteger indexMatching = [resources indexOfObject:matchingResource];
                    [notMatchingIndexes addIndex:indexMatching];
                }
                
                matchingResourceQualifier = foundResourceQualifier;
                matchingResource = resource;
            }
        } else {
            
            [notMatchingIndexes addIndex:resourceIndex];
        }
        
    }];
    
    // 3. If No resources match, return to step 2 and look at the next qualifier.

    if (!matchingResource) {
        
        if (resourceCriterias.count > 0) {
            
            [resourceCriterias removeObjectAtIndex:0];
        }
        
        return [self bestMatchInResource:resources
                   withResourceCriterias:resourceCriterias
                                  forKey:key];
    }
    
    //  If resources matching were found, continue to step 4.

    // 4. Eliminate resource directories that do not include this qualifier.
    
    [resources removeObjectsAtIndexes:notMatchingIndexes];
    
    // 5. Go back and repeat until only one resource remains.
    
    if (resourceCriterias.count > 0) {
        
        [resourceCriterias removeObjectAtIndex:0];
    }
    
    return [self bestMatchInResource:resources
               withResourceCriterias:resourceCriterias
                              forKey:key];
}

#pragma mark - Helper

- (id<MDResourceCriteriaProtocol>)findCriteriaForQualifier:(NSString *)qualifier inCriteriasList:(NSArray *)criterias {
    
    // TODO dictionary?
    
    __block id<MDResourceCriteriaProtocol> criteriaFound = nil;
    
    [criterias enumerateObjectsUsingBlock:^(id<MDResourceCriteriaProtocol> criteria, NSUInteger idx, BOOL *stop) {
        
        if ([criteria respondsToQualifier:qualifier]) {
            
            *stop = YES;
            criteriaFound = criteria;
        }
    }];
    
    return criteriaFound;
}

@end
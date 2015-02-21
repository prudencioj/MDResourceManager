//
//  ResourceFilter.m
//  resources
//
//  Created by Joao Prudencio on 20/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import "MDResourceFilter.h"
#import "MDResourceQualifier.h"
#import "MDResourceCriteriaProtocol.h"

@interface MDResourceFilter ()

@property (nonatomic, strong, readonly) NSArray *criterias;

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
        
        if ([resource meetAllCriteriasForKey:key]) {
            
            [filteredResources addObject:resource];
        }
    }];
    
    return [filteredResources copy];
}

- (NSArray *)bestMatchInResource:(NSMutableArray *)resources
           withResourceCriterias:(NSMutableArray *)resourceCriterias
                          forKey:(NSString *)key {
    
    // we should stop looking if only one resource is available
    // or priority rules are not available anymore
    
    if (resources.count == 1 ||
        resourceCriterias.count == 0) {
        
        return resources;
    }
    
    // 2. Pick the (next) highest-precedence qualifier in the list priorityRules.
    
    __block id<MDResourceCriteriaProtocol> resourceCriteria = resourceCriterias.firstObject;
    
    // 3. Do any of the resource directories include this qualifier?

    __block MDResource *matchingResource = nil;
    __block MDResourceQualifier *matchingResourceQualifier = nil;
    __block NSMutableIndexSet *notMatchingIndexes = [[NSMutableIndexSet alloc] init];
    
    [resources enumerateObjectsUsingBlock:^(MDResource *resource, NSUInteger resourceIndex, BOOL *stop) {
        
        __block MDResourceQualifier *foundResourceQualifier = nil;
        
        if (resource.values[key]) {
            
            foundResourceQualifier = [resource resourceQualifierForCriteria:resourceCriteria];
        }
        
        if ([foundResourceQualifier meetCriteria]) {
            
            // There are cases where multiples resources exist with the same rule.
            // e.g. dimensions-sw200 and dimensions-sw300 in an iPhone6 device.
            // So both conditions are true, an iPhone6 has more than 200 and 300 points width.
            // In these cases we need choose the nearest one using the comparator of the Rule.
            // In this case we would choose dimensions-sw300
            
            if (!matchingResourceQualifier ||
                [foundResourceQualifier compare:matchingResourceQualifier] == NSOrderedAscending) {
            
                if (matchingResourceQualifier) {
                    
                    NSUInteger indexMatching = [resources indexOfObject:matchingResource];
                    [notMatchingIndexes addIndex:indexMatching];
                }
                
                matchingResourceQualifier = foundResourceQualifier;
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
    
    // 6. Go back and repeat until only one resource remains.
    
    if (resourceCriterias.count > 0) {
        
        [resourceCriterias removeObjectAtIndex:0];
    }
    
    return [self bestMatchInResource:resources
               withResourceCriterias:resourceCriterias
                              forKey:key];
}

@end
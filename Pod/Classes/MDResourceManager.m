//
//  ResourceManager.m
//  resources
//
//  Created by Joao Prudencio on 20/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import "MDResourceManager.h"
#import "MDResourcePropertyListParser.h"
#import "MDOrientationResourceCriteria.h"
#import "MDDeviceResourceCriteria.h"
#import "MDResourceFilter.h"

@interface MDResourceManager ()

@property (nonatomic, strong, readonly) NSString *prefixFileName;
@property (nonatomic, strong, readonly) NSArray *criterias;

@property (nonatomic, strong) NSArray *resources;

@property (nonatomic, strong) MDResourceFilter *resourceFilter;

@end

@implementation MDResourceManager

- (instancetype)initWithPrefixFileName:(NSString *)fileName criterias:(NSArray *)criterias {
    
    self = [super init];
    
    if (self) {
        
        _prefixFileName = fileName;
        _criterias = criterias;
        _resourceFilter = [[MDResourceFilter alloc] initWithCriterias:criterias];
    }
    
    return self;
}

- (instancetype)initWithPrefixFileName:(NSString *)fileName {
    
    self = [super init];
    
    if (self) {
        
        _prefixFileName = fileName;
        _criterias = @[[[MDDeviceResourceCriteria alloc] init],
                       [[MDOrientationResourceCriteria alloc] init]];
        _resourceFilter = [[MDResourceFilter alloc] initWithCriterias:_criterias];
    }
    
    return self;
}

#pragma mark - Public

- (void)loadResources {
    
    self.resources = [MDResourcePropertyListParser resourcesWithPrefixFileName:self.prefixFileName
                                                                     criterias:self.criterias];
}

- (id)valueForKey:(NSString *)key {
    
    MDResource *resource = [self.resourceFilter filterResources:self.resources
                                                         forKey:key];
    return resource.values[key];
}

// TODO type validations

- (NSString *)stringForKey:(NSString *)key {
    
    id value = [self valueForKey:key];
    NSString *stringValue = value;
    return stringValue;
}

- (NSNumber *)numberForKey:(NSString *)key {
    
    id value = [self valueForKey:key];
    NSNumber *dimension = value;
    return dimension;
}

- (CGFloat)floatForKey:(NSString *)key {
    
    id value = [self valueForKey:key];
    NSNumber *dimension = value;
    return dimension.floatValue;
}

@end
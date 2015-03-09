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

static NSString * const kResourceManagerKeyFontName = @"fontName";
static NSString * const kResourceManagerKeyFontSize = @"fontSize";

@interface MDResourceManager ()

@property (nonatomic, strong, readonly) NSString *prefixFileName;
@property (nonatomic, strong) NSArray *resources;

@property (nonatomic, strong) MDResourceFilter *resourceFilter;

@property (nonatomic, strong) NSCache *cache;
@property (nonatomic) BOOL canCacheResources;

@end

@implementation MDResourceManager

#pragma mark - Initialization

- (instancetype)initWithPrefixFileName:(NSString *)fileName
                             criterias:(NSArray *)criterias {
    
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

#pragma mark - Properties 

- (void)setCriterias:(NSArray *)criterias {
    
    _criterias = criterias;
    
    // create a new instance, or just set a criterias property too?
    self.resourceFilter = [[MDResourceFilter alloc] initWithCriterias:criterias];
    
    // invalidate the cache everytime the criterias change.
    [self invalidateCache];
}

#pragma mark - Public 

- (void)loadResources {
    
    if (!self.resources) {
        
        // FIXME - we should create an instance of the parser.
        //       - we should have more than one parser, json, plist,xml
        //       - find a neat way to avoid loading files, that we know will never match our criterias.
        //         
        self.resources = [MDResourcePropertyListParser resourcesWithPrefixFileName:self.prefixFileName];
    }
}

#pragma mark - Public Fetching values

- (id)valueForKey:(NSString *)key {
    
    return [self valueForKey:key defaultValue:nil];
}

- (id)valueForKey:(NSString *)key defaultValue:(id)defaultValue {

    // TODO proper lazy loading? loadResources it's not really necesary.
    [self loadResources];
    
    id value = [self cachedValueForKey:key];
    
    if (!value) {
        
        MDResource *resource = [self.resourceFilter filterResources:self.resources
                                                             forKey:key];
        
        value = resource.values[key];
        [self cacheValue:value forKey:key];
    }
    
    return value == nil? defaultValue: value;
}

- (NSString *)stringForKey:(NSString *)key {
    
    return [self stringForKey:key defaultValue:nil];
}

- (NSString *)stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue {
    
    id value = [self valueForKey:key];
    NSString *stringValue = value;
    return stringValue == nil? defaultValue: stringValue;
}

- (NSNumber *)numberForKey:(NSString *)key {
    
    return [self numberForKey:key defaultValue:nil];
}

- (NSNumber *)numberForKey:(NSString *)key defaultValue:(NSNumber *)defaultValue {
    
    id value = [self valueForKey:key];
    NSNumber *numberValue = value;
    return numberValue == nil? defaultValue: numberValue;
}

- (NSArray *)arrayForKey:(NSString *)key {
    
    return [self arrayForKey:key defaultValue:nil];
}

- (NSArray *)arrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue {
    
    id value = [self valueForKey:key];
    NSArray *arrayValue = [value isKindOfClass:[NSArray class]]? value: nil;
    return arrayValue == nil? defaultValue: arrayValue;
}

- (NSDictionary *)dictionaryForKey:(NSString *)key {
    
    return [self dictionaryForKey:key defaultValue:nil];
}

- (NSDictionary *)dictionaryForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue {
    
    id value = [self valueForKey:key];
    NSDictionary *dictionaryValue = [value isKindOfClass:[NSDictionary class]]? value: nil;
    return dictionaryValue == nil? defaultValue: dictionaryValue;
}

- (CGFloat)floatForKey:(NSString *)key {
    
    return [self floatForKey:key defaultValue:0.0f];
}

- (CGFloat)floatForKey:(NSString *)key defaultValue:(CGFloat)defaultValue {
    
    id value = [self valueForKey:key];
    NSNumber *numberValue = [value isKindOfClass:[NSNumber class]]? value: nil;
    return numberValue == nil? defaultValue: numberValue.floatValue;
}

- (NSInteger)integerForKey:(NSString *)key {
    
    return [self integerForKey:key defaultValue:0];
}

- (NSInteger)integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue {
    
    id value = [self valueForKey:key];
    NSNumber *numberValue = [value isKindOfClass:[NSNumber class]]? value: nil;
    return numberValue == nil? defaultValue: numberValue.integerValue;
}

- (BOOL)boolForKey:(NSString *)key {
    
    return [self boolForKey:key defaultValue:NO];
}

- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue {
    
    id value = [self valueForKey:key];
    NSNumber *numberValue = [value isKindOfClass:[NSNumber class]]? value: nil;
    return numberValue == nil? defaultValue: numberValue.boolValue;
}

- (UIEdgeInsets)edgeInsetsForKey:(NSString *)key {
    
    return [self edgeInsetsForKey:key defaultValue:UIEdgeInsetsZero];
}

- (UIEdgeInsets)edgeInsetsForKey:(NSString *)key defaultValue:(UIEdgeInsets)defaultValue {
    
    id value = [self valueForKey:key];
    
    if ([value isKindOfClass:[NSArray class]]) {
        
        NSArray *edgesArray = value;
        
        if (edgesArray.count == 4) {
            
            return UIEdgeInsetsMake([edgesArray[0] floatValue],
                                    [edgesArray[1] floatValue],
                                    [edgesArray[2] floatValue],
                                    [edgesArray[3] floatValue]);
        }
    }
    
    return defaultValue;
}

- (UIFont *)fontForKey:(NSString *)key {
    
    return [self fontForKey:key defaultValue:nil];
}

- (UIFont *)fontForKey:(NSString *)key defaultValue:(UIFont *)defaultValue {
    
    NSDictionary *fontDict = [self dictionaryForKey:key];
    if ([fontDict isKindOfClass:[NSDictionary class]]) {
        
        UIFont *fontObject = [UIFont fontWithName:fontDict[kResourceManagerKeyFontName]
                                             size:[fontDict[kResourceManagerKeyFontSize] floatValue]];
        if (fontObject) {
            
            return fontObject;
        }
        else {
            
            return defaultValue;
        }
    }
    
    return defaultValue;
}

#pragma mark - Manage cache

// TODO move this to other class

- (NSCache *)cache {
    
    if (!_cache) {
        
        _cache = [[NSCache alloc] init];
    }
    
    return _cache;
}

- (BOOL)canCacheResources {
    
    if (!_canCacheResources) {
        
        _canCacheResources = [self canCacheResourcesWithCriterias:self.criterias];
    }
    
    return _canCacheResources;
}

- (void)cacheValue:(id)value forKey:(NSString *)key {
    
    if (self.canCacheResources && value) {
        
        [self.cache setObject:value forKey:key];
    }
}

- (id)cachedValueForKey:(NSString *)key {
    
    return [self.cache objectForKey:key];
}

- (BOOL)canCacheResourcesWithCriterias:(NSArray *)criterias {
    
    // only cache when no criteria changes in run time
    
    __block BOOL canCache = YES;
    
    [criterias enumerateObjectsUsingBlock:^(id<MDResourceCriteriaProtocol> criteria, NSUInteger idx, BOOL *stop) {
        
        if ([criteria criteriaChangesInRuntime]) {
            
            canCache = NO;
            *stop = YES;
        }
    }];
    
    return canCache;
}

- (void)invalidateCache {
    
    self.canCacheResources = [self canCacheResourcesWithCriterias:self.criterias];
    [self.cache removeAllObjects];
}

@end
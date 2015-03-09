//
//  EMResourceLoader.m
//  Pods
//
//  Created by Joao Prudencio on 09/03/15.
//
//

#import "MDResourceLoader.h"
#import "MDResourcePropertyListParser.h"

@interface MDResourceLoader ()

@property (nonatomic, strong, readonly) NSCache *resourceCache;

@end

@implementation MDResourceLoader

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        _shouldUseCache = YES;
    }
    
    return self;
}

- (NSArray *)resourcesForPrefixFileName:(NSString *)prefixFileName {
    
    NSArray *resources = [self.resourceCache objectForKey:prefixFileName];
    
    if (!resources) {
     
        resources = [self loadResourcesForPrefixFileName:prefixFileName];
        [self.resourceCache setObject:resources forKey:prefixFileName];
    }
    
    return resources;
}

#pragma mark - Private

- (NSArray *)loadResourcesForPrefixFileName:(NSString *)prefixFileName {
    
    return [MDResourcePropertyListParser resourcesWithPrefixFileName:prefixFileName];
}

#pragma mark - Manage Resource cache

- (NSCache *)resourceCache {
    
    static NSCache *resourceCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        resourceCache = [[NSCache alloc] init];
    });
    
    return resourceCache;
}

@end
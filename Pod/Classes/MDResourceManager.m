//
//  ResourceManager.m
//  resources
//
//  Created by Joao Prudencio on 20/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import "MDResourceManager.h"
#import "MDSmallestWidthRule.h"
#import "MDOrientationRule.h"
#import "MDResourceFilter.h"
#import "MDRuleFactory.h"
#import "MDResource.h"

static NSString *const kDefaultFileName = @"dimensions";

@interface MDResourceManager ()

@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSArray *resources;

@end

@implementation MDResourceManager

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        _fileName = kDefaultFileName;
        
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithFileName:(NSString *)fileName {

    self = [super init];
    
    if (self) {
        
        _fileName = fileName;
        
        [self commonInit];
    }
    
    return self;
}

#pragma mark - Public

- (void)loadResources {
    
    self.resources = [self loadConfigurationsForFileName:self.fileName].copy;
}

- (CGFloat)floatForKey:(NSString *)key {
    
    MDResource *resource = [MDResourceFilter filterResources:self.resources forKey:key];
    NSNumber *dimension = resource.values[key];
    return dimension.floatValue;
}

- (id)valueForKey:(NSString *)key {
    
    MDResource *resource = [MDResourceFilter filterResources:self.resources forKey:key];
    return resource.values[key];
}

#pragma mark - Private 

- (void)commonInit {
    
    self.resources = [self loadConfigurationsForFileName:self.fileName];
}

- (NSArray *)loadConfigurationsForFileName:(NSString *)fileName {
    
    NSString *bundleRoot = [[NSBundle mainBundle] bundlePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *dirContents = [fileManager contentsOfDirectoryAtPath:bundleRoot error:nil];
    NSPredicate *extensionPredicate = [NSPredicate predicateWithFormat:@"self ENDSWITH '.plist'"];
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"SELF like[c] %@",
                                  [NSString stringWithFormat:@"%@*",fileName]];
    
    NSCompoundPredicate *predicate = [[NSCompoundPredicate alloc] initWithType:NSAndPredicateType
                                                                 subpredicates:@[extensionPredicate,namePredicate]];
    NSArray *resourceFileNames = [dirContents filteredArrayUsingPredicate:predicate];
    
    NSMutableArray *resources = @[].mutableCopy;
    
    [resourceFileNames enumerateObjectsUsingBlock:^(NSString *file, NSUInteger idx, BOOL *stop) {
        
        NSString* fileName = [[file lastPathComponent] stringByDeletingPathExtension];
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@".plist"];
        NSDictionary *values = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSMutableArray *rules = @[].mutableCopy;
        NSMutableArray *qualifiersArray = [fileName componentsSeparatedByString:@"-"].mutableCopy;
        
        if (qualifiersArray.count > 1) {
            
            [qualifiersArray removeObjectAtIndex:0];
            
            [qualifiersArray enumerateObjectsUsingBlock:^(NSString *qualifier, NSUInteger idx, BOOL *stop) {
                
                MDAbstractRule *rule = [MDRuleFactory makeRuleWithQualifier:qualifier];
                
                if (rule) {
                    
                    [rules addObject:rule];
                }
            }];
        }
        
        MDResource *resource = [[MDResource alloc] initWithValues:values rules:rules.copy];
        
        [resources addObject:resource];
        
    }];
    
    return resources.copy;
}

@end
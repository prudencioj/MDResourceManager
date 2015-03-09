//
//  ResourceManager.h
//  resources
//
//  Created by Joao Prudencio on 20/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MDResourceManager : NSObject

/**
 *  The criterias to apply the filter can be changed at any time.
 *  A criteria must implement MDResourceCriteriaProtocol.
 */
@property (nonatomic, strong) NSArray *criterias;

// TODO init with other file extensions, at the moment only supports .plist

#pragma mark - Initialization

/** @brief Manage resources resource files considering the criterias.
 *  @param fileName Prefix filename of your .plist resource files
 *  @param criterias list of criterias MDResourceCriteriaProtocol used to filter your resources.
 *         the order matters, it should be ordered by the most important criteria first
 */
- (instancetype)initWithPrefixFileName:(NSString *)fileName
                             criterias:(NSArray *)criterias;

/** @brief Manage resources resource files considering the criterias
 *      The default criterias will be used: device and orientation.
 *  @param fileName Prefix filename of your .plist resource files
 */
- (instancetype)initWithPrefixFileName:(NSString *)fileName;


/** @brief Load the resource files with the filename prefix.
 *  @warning loading resources reads from disk.
 */
- (void)loadResources;

// TODO support for async loading of resources
//- (void)loadResourcesAsync:(void (^)(BOOL success))completion;

#pragma mark - Fetching values

- (id)valueForKey:(NSString *)key;
- (id)valueForKey:(NSString *)key defaultValue:(id)defaultValue;

- (NSString *)stringForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key defaultValue:(NSString *)defaultValue;

- (NSNumber *)numberForKey:(NSString *)key;
- (NSNumber *)numberForKey:(NSString *)key defaultValue:(NSNumber *)defaultValue;

- (NSArray *)arrayForKey:(NSString *)key;
- (NSArray *)arrayForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;

- (NSDictionary *)dictionaryForKey:(NSString *)key;
- (NSDictionary *)dictionaryForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue;

- (CGFloat)floatForKey:(NSString *)key;
- (CGFloat)floatForKey:(NSString *)key defaultValue:(CGFloat)defaultValue;

- (NSInteger)integerForKey:(NSString *)key;
- (NSInteger)integerForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;

- (BOOL)boolForKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key defaultValue:(BOOL)defaultValue;

- (UIEdgeInsets)edgeInsetsForKey:(NSString *)key;
- (UIEdgeInsets)edgeInsetsForKey:(NSString *)key defaultValue:(UIEdgeInsets)defaultValue;

- (UIFont *)fontForKey:(NSString *)key;
- (UIFont *)fontForKey:(NSString *)key defaultValue:(UIFont *)defaultValue;

@end
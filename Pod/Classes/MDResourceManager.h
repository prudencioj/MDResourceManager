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

- (instancetype)initWithPrefixFileName:(NSString *)fileName criterias:(NSArray *)criterias;

- (void)loadResources;

- (id)valueForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;
- (NSNumber *)numberForKey:(NSString *)key;
- (CGFloat)floatForKey:(NSString *)key;

@end
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

- (instancetype)initWithFileName:(NSString *)fileName;

- (CGFloat)floatForKey:(NSString *)key;
- (id)valueForKey:(NSString *)key;

@end
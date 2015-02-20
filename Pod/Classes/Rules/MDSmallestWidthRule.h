//
//  SmallestWidthRule.h
//  resources
//
//  Created by Joao Prudencio on 20/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

// The fundamental size of a screen, as indicated by the shortest dimension of the available screen area.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MDAbstractRule.h"

@interface MDSmallestWidthRule : MDAbstractRule

- (instancetype)initWithValue:(CGFloat)value;

@property (nonatomic, readonly) CGFloat value;

@end

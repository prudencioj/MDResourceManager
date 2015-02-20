//
//  OrientationRule.h
//  resources
//
//  Created by Joao Prudencio on 20/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MDAbstractRule.h"

@interface MDOrientationRule : MDAbstractRule

- (instancetype)initWithPortrait:(BOOL)isPortrait;

@property (nonatomic, readonly) BOOL isPortrait;

@end
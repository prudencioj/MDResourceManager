//
//  MDDeviceRule.h
//  Pods
//
//  Created by Joao Prudencio on 21/02/15.
//
//

#import "MDAbstractRule.h"

@interface MDDeviceRule : MDAbstractRule

- (instancetype)initWithDevice:(NSString *)device;

@property (nonatomic, readonly) NSString *device;
@property (nonatomic, readonly) NSString *model;

@end
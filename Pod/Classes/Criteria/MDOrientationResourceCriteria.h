//
//  MDOrientationResourceCriteria.h
//  Pods
//
//  Created by Joao Prudencio on 21/02/15.
//
//

#import <Foundation/Foundation.h>
#import "MDResourceCriteriaProtocol.h"

@interface MDOrientationResourceCriteria : NSObject<MDResourceCriteriaProtocol>

@property (nonatomic) UIInterfaceOrientation interfaceOrientation;

- (instancetype)initWithInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end
//
//  MDResourceQualifier.h
//  Pods
//
//  Created by Joao Prudencio on 21/02/15.
//
//

#import <Foundation/Foundation.h>
#import "MDResourceCriteriaProtocol.h"

@interface MDResourceQualifier : NSObject

@property (nonatomic, strong, readonly) NSString *qualifier;
@property (nonatomic, strong, readonly) id<MDResourceCriteriaProtocol> criteria;

- (instancetype)initWithQualifier:(NSString *)qualifier criteria:(id<MDResourceCriteriaProtocol>)criteria;

- (BOOL)meetCriteria;
- (NSComparisonResult)compare:(MDResourceQualifier *)resourceQualifier;

@end
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
@property (nonatomic, strong) Class criteriaClass;

- (instancetype)initWithQualifier:(NSString *)qualifier criteriaClass:(Class)criteriaClass;

@end
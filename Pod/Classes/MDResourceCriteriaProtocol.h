//
//  MDResourceCriteriaProtocol.h
//  Pods
//
//  Created by Joao Prudencio on 21/02/15.
//
//

#import <Foundation/Foundation.h>

@protocol MDResourceCriteriaProtocol <NSObject>

@required
- (BOOL)meetCriteriaWith:(NSString *)qualifier;
- (BOOL)respondsToQualifier:(NSString *)qualifier;
- (BOOL)shouldOverrideQualifier:(NSString *)qualifier1 withQualifier:(NSString *)qualifier2;

@end
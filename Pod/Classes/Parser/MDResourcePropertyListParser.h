//
//  MDResourcePropertyListParser.h
//  Pods
//
//  Created by Joao Prudencio on 21/02/15.
//
//

#import <Foundation/Foundation.h>

@interface MDResourcePropertyListParser : NSObject

+ (NSArray *)resourcesWithPrefixFileName:(NSString *)prefixFileName
                               criterias:(NSArray *)criterias;

@end
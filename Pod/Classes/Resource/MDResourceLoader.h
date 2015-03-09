//
//  EMResourceLoader.h
//  Pods
//
//  Created by Joao Prudencio on 09/03/15.
//
//

#import <Foundation/Foundation.h>

@interface MDResourceLoader : NSObject

@property (nonatomic) BOOL shouldUseCache;

- (NSArray *)resourcesForPrefixFileName:(NSString *)prefixFileName;

@end
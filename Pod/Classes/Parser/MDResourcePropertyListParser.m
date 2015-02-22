//
//  MDResourcePropertyListParser.m
//  Pods
//
//  Created by Joao Prudencio on 21/02/15.
//
//

#import "MDResourcePropertyListParser.h"
#import "MDResourceCriteriaProtocol.h"
#import "MDResourceQualifier.h"
#import "MDResource.h"

static NSString *const kFileExtension = @".plist";
static NSString *const kExtensionPredicate = @"self ENDSWITH '.plist'";
static NSString *const kNamePredicate = @"SELF like[c] %@";
static NSString *const kQualifierSeparator = @"-";

@implementation MDResourcePropertyListParser

+ (NSArray *)resourcesWithPrefixFileName:(NSString *)prefixFileName
                               criterias:(NSArray *)criterias {

    NSString *bundleRoot = [[NSBundle mainBundle] bundlePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *dirContents = [fileManager contentsOfDirectoryAtPath:bundleRoot error:nil];
    NSPredicate *extensionPredicate = [NSPredicate predicateWithFormat:kExtensionPredicate];
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:kNamePredicate,
                                  [NSString stringWithFormat:@"%@*",prefixFileName]];
    
    NSCompoundPredicate *predicate = [[NSCompoundPredicate alloc] initWithType:NSAndPredicateType
                                                                 subpredicates:@[extensionPredicate,namePredicate]];
    NSArray *resourceFileNames = [dirContents filteredArrayUsingPredicate:predicate];
    
    NSMutableArray *resources = @[].mutableCopy;
    
    [resourceFileNames enumerateObjectsUsingBlock:^(NSString *file, NSUInteger idx, BOOL *stop) {
        
        NSString* fileName = [[file lastPathComponent] stringByDeletingPathExtension];
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:kFileExtension];
        NSDictionary *values = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSArray *resourceQualifiers = [MDResourcePropertyListParser resourceQualifiersFromString:fileName
                                                                                       criterias:criterias];
        
        MDResource *resource = [[MDResource alloc] initWithValues:values
                                               resourceQualifiers:resourceQualifiers];
        
        [resources addObject:resource];
    }];
    
    return resources.copy;
}

+ (NSArray *)resourceQualifiersFromString:(NSString *)resourceQualifiersString criterias:(NSArray *)criterias {
    
    NSMutableArray *resourceQualifiers = @[].mutableCopy;
    NSMutableArray *qualifiersArray = [resourceQualifiersString componentsSeparatedByString:kQualifierSeparator].mutableCopy;
    
    if (qualifiersArray.count > 1) {
        
        [qualifiersArray removeObjectAtIndex:0];
        
        [qualifiersArray enumerateObjectsUsingBlock:^(NSString *qualifier, NSUInteger idx, BOOL *stop) {
            
            [criterias enumerateObjectsUsingBlock:^(id<MDResourceCriteriaProtocol> criteria, NSUInteger idx, BOOL *stop) {
                
                if ([criteria respondsToQualifier:qualifier]) {
                    
                    MDResourceQualifier *resourceQualifier = [[MDResourceQualifier alloc] initWithQualifier:qualifier criteriaClass:[criteria class]];
                    [resourceQualifiers addObject:resourceQualifier];
                    
                    *stop = YES;
                }
            }];
        }];
    }
    
    return resourceQualifiers.copy;
}

@end

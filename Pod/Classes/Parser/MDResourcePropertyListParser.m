//
//  MDResourcePropertyListParser.m
//  Pods
//
//  Created by Joao Prudencio on 21/02/15.
//
//

#import "MDResourcePropertyListParser.h"
#import "MDResourceCriteriaProtocol.h"
#import "MDResource.h"

static NSString *const kFileExtension = @".plist";
static NSString *const kExtensionPredicate = @"self ENDSWITH '.plist'";
static NSString *const kNamePredicate = @"SELF like[c] %@";
static NSString *const kQualifierSeparator = @"-";

@implementation MDResourcePropertyListParser

+ (NSArray *)resourcesWithPrefixFileName:(NSString *)prefixFileName {

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
        
        NSArray *resourceQualifiers = [MDResourcePropertyListParser resourceQualifiersFromString:fileName];
        
        MDResource *resource = [[MDResource alloc] initWithFileName:fileName
                                                             values:values
                                                 resourceQualifiers:resourceQualifiers];
        
        [resources addObject:resource];
    }];
    
    return resources.copy;
}

+ (NSArray *)resourceQualifiersFromString:(NSString *)resourceQualifiersString {
    
    NSMutableArray *qualifiersArray = [resourceQualifiersString componentsSeparatedByString:kQualifierSeparator].mutableCopy;
    
    if (qualifiersArray.count > 0) {
        
        [qualifiersArray removeObjectAtIndex:0];
    }
    
    return qualifiersArray.copy;
}

@end

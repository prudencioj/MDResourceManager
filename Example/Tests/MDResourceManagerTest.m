//
//  MDResourceManagerTests.m
//  MDResourceManagerTests
//
//  Created by Joao Prudencio on 02/20/2015.
//  Copyright (c) 2014 Joao Prudencio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MDResourceManager.h"
#import "MDDeviceResourceCriteria.h"
#import "MDOrientationResourceCriteria.h"
#import "OCMock.h"

@interface MDResourceManagerTest : XCTestCase

@end

@implementation MDResourceManagerTest

- (void)testValueFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    id stringValue = [resourceManager valueForKey:@"stringKey"];
    XCTAssert(stringValue);
    NSString *nonExistingValue = [resourceManager valueForKey:@"notExistingKey"];
    XCTAssert(!nonExistingValue);
}

- (void)testStringFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    NSString *stringValue = [resourceManager stringForKey:@"stringKey"];
    XCTAssert([stringValue isEqualToString:@"some string"]);
    NSString *nonExistingValue = [resourceManager stringForKey:@"notExistingKey"];
    XCTAssert(!nonExistingValue);
}

- (void)testDictionaryFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    NSDictionary *dictionaryValue = [resourceManager dictionaryForKey:@"dictionaryKey"];
    XCTAssert(dictionaryValue && [dictionaryValue isKindOfClass:[NSDictionary class]]);
    NSDictionary *nonExistingValue = [resourceManager dictionaryForKey:@"notExistingKey"];
    XCTAssert(!nonExistingValue);
}

- (void)testArrayFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    NSArray *arrayValue = [resourceManager arrayForKey:@"arrayKey"];
    XCTAssert(arrayValue && [arrayValue isKindOfClass:[NSArray class]]);
    NSArray *nonExistingValue = [resourceManager arrayForKey:@"notExistingKey"];
    XCTAssert(!nonExistingValue);
}

- (void)testNumberFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    NSNumber *numberValue = [resourceManager numberForKey:@"numberKey"];
    XCTAssert([numberValue isEqual:@(5)]);
    NSNumber *nonExistingValue = [resourceManager numberForKey:@"notExistingKey"];
    XCTAssert(!nonExistingValue);
}

- (void)testIntegerFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    NSInteger integerValue = [resourceManager integerForKey:@"numberKey"];
    XCTAssert(integerValue == 5);
    NSInteger nonExistingValue = [resourceManager integerForKey:@"notExistingKey"];
    XCTAssert(!nonExistingValue);
}

- (void)testFloatFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    CGFloat floatValue = [resourceManager floatForKey:@"floatKey"];
    XCTAssert(floatValue == 6.7f);
    CGFloat nonExistingValue = [resourceManager floatForKey:@"notExistingKey"];
    XCTAssert(nonExistingValue == 0.0f);
}

- (void)testBoolFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    BOOL boolValue = [resourceManager boolForKey:@"boolKey"];
    XCTAssert(boolValue);
    BOOL nonExistingValue = [resourceManager boolForKey:@"notExistingKey"];
    XCTAssert(!nonExistingValue);
}

@end
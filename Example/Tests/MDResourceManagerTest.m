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
#import "MDDeviceUtil.h"

@interface MDResourceManagerTest : XCTestCase

@end

@implementation MDResourceManagerTest

- (void)testValueFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    id stringValue = [resourceManager valueForKey:@"stringKey"];
    XCTAssertNotNil(stringValue);
    XCTAssertEqualObjects(stringValue, @"some string");
    NSString *nonExistingValue = [resourceManager valueForKey:@"notExistingKey"];
    XCTAssertNil(nonExistingValue);
}

- (void)testStringFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    NSString *stringValue = [resourceManager stringForKey:@"stringKey"];
    XCTAssertNotNil(stringValue);
    XCTAssertEqualObjects(stringValue, @"some string");
    NSString *nonExistingValue = [resourceManager stringForKey:@"notExistingKey"];
    XCTAssertNil(nonExistingValue);
}

- (void)testDictionaryFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    NSDictionary *dictionaryValue = [resourceManager dictionaryForKey:@"dictionaryKey"];
    XCTAssertNotNil(dictionaryValue);
    XCTAssert([dictionaryValue isKindOfClass:[NSDictionary class]]);
    NSDictionary *nonExistingValue = [resourceManager dictionaryForKey:@"notExistingKey"];
    XCTAssertNil(nonExistingValue);
}

- (void)testArrayFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    NSArray *arrayValue = [resourceManager arrayForKey:@"arrayKey"];
    XCTAssertNotNil(arrayValue);
    XCTAssert([arrayValue isKindOfClass:[NSArray class]]);
    NSArray *nonExistingValue = [resourceManager arrayForKey:@"notExistingKey"];
    XCTAssertNil(nonExistingValue);
}

- (void)testNumberFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    NSNumber *numberValue = [resourceManager numberForKey:@"numberKey"];
    XCTAssertEqualObjects(numberValue, @(5));
    NSNumber *nonExistingValue = [resourceManager numberForKey:@"notExistingKey"];
    XCTAssertNil(nonExistingValue);
}

- (void)testIntegerFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    NSInteger integerValue = [resourceManager integerForKey:@"numberKey"];
    XCTAssertEqual(integerValue, 5);
    NSInteger nonExistingValue = [resourceManager integerForKey:@"notExistingKey"];
    XCTAssertEqual(nonExistingValue, 0);
}

- (void)testFloatFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    CGFloat floatValue = [resourceManager floatForKey:@"floatKey"];
    XCTAssertEqual(floatValue, 6.7f);
    CGFloat nonExistingValue = [resourceManager floatForKey:@"notExistingKey"];
    XCTAssertEqual(nonExistingValue, 0.0f);
}

- (void)testBoolFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    BOOL boolValue = [resourceManager boolForKey:@"boolKey"];
    XCTAssertTrue(boolValue);
    BOOL nonExistingValue = [resourceManager boolForKey:@"notExistingKey"];
    XCTAssertFalse(nonExistingValue);
}

@end
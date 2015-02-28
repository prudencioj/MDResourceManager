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

- (void)testChangingCriteriasResourceManager {
    
    id deviceUtilMock = OCMClassMock([MDDeviceUtil class]);
    OCMStub([deviceUtilMock isDevicePortrait]).andReturn(NO);
    MDOrientationResourceCriteria *criteria = [[MDOrientationResourceCriteria alloc] init];

    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"
                                                                                 criterias:@[criteria]];
    [resourceManager loadResources];
    
    XCTAssertEqualObjects([resourceManager stringForKey:@"anotherKey"], @"anothervaluelandscape");
    
    [deviceUtilMock stopMocking];
    
    // now change the criterias, and check if the manager fetch the correct value
    
    resourceManager.criterias = @[];
    XCTAssertEqualObjects([resourceManager stringForKey:@"anotherKey"], @"anothervalue");
}

- (void)testChangingCriteriasInvalidatesCacheResourceManager {
    
    id deviceUtilMock = OCMClassMock([MDDeviceUtil class]);
    OCMStub([deviceUtilMock isDevicePortrait]).andReturn(NO);
    OCMStub([deviceUtilMock isDevicePad]).andReturn(YES);
    OCMStub([deviceUtilMock deviceVersion]).andReturn(@"ipad");
    
    MDDeviceResourceCriteria *deviceCriteria = [[MDDeviceResourceCriteria alloc] init];
    MDOrientationResourceCriteria *orientationCriteria = [[MDOrientationResourceCriteria alloc] init];

    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    XCTAssertEqualObjects([resourceManager stringForKey:@"anotherKey"], @"anothervalueipad");
    
    // now change the criterias, and check if the manager fetch the correct value
    // test criterias that changes in run time, that can be cached.
    // changing criterias should invalidate the cache
    
    resourceManager.criterias = @[orientationCriteria];
    XCTAssertEqualObjects([resourceManager stringForKey:@"anotherKey"], @"anothervaluelandscape");
    
    resourceManager.criterias = @[deviceCriteria];
    XCTAssertEqualObjects([resourceManager stringForKey:@"anotherKey"], @"anothervalueipad");
    
    resourceManager.criterias = @[];
    XCTAssertEqualObjects([resourceManager stringForKey:@"anotherKey"], @"anothervalue");
    
    [deviceUtilMock stopMocking];
}

@end
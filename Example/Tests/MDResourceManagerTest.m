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
    
    NSString *nonExistingValueDefault = [resourceManager valueForKey:@"notExistingKeyDefault" defaultValue:@"default"];
    XCTAssertEqualObjects(nonExistingValueDefault, @"default");
}

- (void)testStringFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    NSString *stringValue = [resourceManager stringForKey:@"stringKey"];
    XCTAssertNotNil(stringValue);
    XCTAssertEqualObjects(stringValue, @"some string");
    NSString *nonExistingValue = [resourceManager stringForKey:@"notExistingKey"];
    XCTAssertNil(nonExistingValue);
    
    NSString *nonExistingValueDefault = [resourceManager valueForKey:@"notExistingKeyDefault" defaultValue:@"default"];
    XCTAssertEqualObjects(nonExistingValueDefault, @"default");
}

- (void)testDictionaryFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    NSDictionary *dictionaryValue = [resourceManager dictionaryForKey:@"dictionaryKey"];
    XCTAssertNotNil(dictionaryValue);
    XCTAssert([dictionaryValue isKindOfClass:[NSDictionary class]]);
    NSDictionary *nonExistingValue = [resourceManager dictionaryForKey:@"notExistingKey"];
    XCTAssertNil(nonExistingValue);
    
    NSDictionary *nonExistingValueDefault = [resourceManager dictionaryForKey:@"notExistingKeyDefault" defaultValue:@{@"1":@"2"}];
    XCTAssertEqualObjects(nonExistingValueDefault, @{@"1":@"2"});
}

- (void)testArrayFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    NSArray *arrayValue = [resourceManager arrayForKey:@"arrayKey"];
    XCTAssertNotNil(arrayValue);
    XCTAssert([arrayValue isKindOfClass:[NSArray class]]);
    NSArray *nonExistingValue = [resourceManager arrayForKey:@"notExistingKey"];
    XCTAssertNil(nonExistingValue);
    
    NSArray *nonExistingValueDefault = [resourceManager arrayForKey:@"notExistingKeyDefault" defaultValue:@[@"1"]];
    XCTAssertEqualObjects(nonExistingValueDefault, @[@"1"]);
}

- (void)testNumberFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    NSNumber *numberValue = [resourceManager numberForKey:@"numberKey"];
    XCTAssertEqualObjects(numberValue, @(5));
    NSNumber *nonExistingValue = [resourceManager numberForKey:@"notExistingKey"];
    XCTAssertNil(nonExistingValue);
    
    NSNumber *nonExistingValueDefault = [resourceManager numberForKey:@"notExistingKeyDefault" defaultValue:@(8)];
    XCTAssertEqualObjects(nonExistingValueDefault, @(8));
}

- (void)testIntegerFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    NSInteger integerValue = [resourceManager integerForKey:@"numberKey"];
    XCTAssertEqual(integerValue, 5);
    NSInteger nonExistingValue = [resourceManager integerForKey:@"notExistingKey"];
    XCTAssertEqual(nonExistingValue, 0);
    
    NSInteger nonExistingValueDefault = [resourceManager integerForKey:@"notExistingKeyDefault" defaultValue:8];
    XCTAssertEqual(nonExistingValueDefault, 8);
}

- (void)testFloatFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    CGFloat floatValue = [resourceManager floatForKey:@"floatKey"];
    XCTAssertEqual(floatValue, 6.7f);
    CGFloat nonExistingValue = [resourceManager floatForKey:@"notExistingKey"];
    XCTAssertEqual(nonExistingValue, 0.0f);
    
    NSInteger nonExistingValueDefault = [resourceManager floatForKey:@"notExistingKeyDefault" defaultValue:8.0f];
    XCTAssertEqual(nonExistingValueDefault, 8.0f);
}

- (void)testBoolFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    BOOL boolValue = [resourceManager boolForKey:@"boolKey"];
    XCTAssertTrue(boolValue);
    BOOL nonExistingValue = [resourceManager boolForKey:@"notExistingKey"];
    XCTAssertFalse(nonExistingValue);
    
    BOOL nonExistingValueDefault = [resourceManager boolForKey:@"notExistingKeyDefault" defaultValue:YES];
    XCTAssertEqual(nonExistingValueDefault, YES);
}

- (void)testEdgeInsetsFetchingResourceManager {
    
    MDResourceManager *resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"];
    [resourceManager loadResources];
    
    UIEdgeInsets edgeInsets = [resourceManager edgeInsetsForKey:@"edgeInsetsKey"];
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(1, 2, 3, 4), edgeInsets));
    XCTAssertTrue(!UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(5, 2, 6, 1), edgeInsets));
    
    UIEdgeInsets nonExistingEdgeInsets1 = [resourceManager edgeInsetsForKey:@"invalidKey"];
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, nonExistingEdgeInsets1));
    
    UIEdgeInsets invalidEdgeInsets1 = [resourceManager edgeInsetsForKey:@"wrongInsetsKey1"];
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, invalidEdgeInsets1));
    
    UIEdgeInsets invalidEdgeInsets2 = [resourceManager edgeInsetsForKey:@"wrongInsetsKey2"];
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, invalidEdgeInsets2));
    
    UIEdgeInsets invalidEdgeInsets3 = [resourceManager edgeInsetsForKey:@"wrongInsetsKey3"];
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, invalidEdgeInsets3));
    
    UIEdgeInsets invalidEdgeInsets4 = [resourceManager edgeInsetsForKey:@"wrongInsetsKey4"];
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, invalidEdgeInsets4));
    
    UIEdgeInsets nonExistingValueDefault = [resourceManager edgeInsetsForKey:@"notExistingKeyDefault" defaultValue:UIEdgeInsetsMake(1, 2, 55, 12)];
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(1, 2, 55, 12), nonExistingValueDefault));
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
//
//  MDDeviceResourceCriteriaTest.m
//  MDResourceManager
//
//  Created by Joao Prudencio on 22/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "OCMock.h"
#import "MDDeviceResourceCriteria.h"
#import "MDDeviceUtil.h"
#import "OCMock.h"

@interface MDDeviceResourceCriteriaTest : XCTestCase

@end

@implementation MDDeviceResourceCriteriaTest

- (void)testCriteriaRespondsTo {

    MDDeviceResourceCriteria *deviceCriteria = [[MDDeviceResourceCriteria alloc] init];

    XCTAssert([deviceCriteria respondsToQualifier:@"ipad"]);
    XCTAssert([deviceCriteria respondsToQualifier:@"iphone"]);
    
    XCTAssert([deviceCriteria respondsToQualifier:@"iphone6plus"]);
    
    XCTAssert(![deviceCriteria respondsToQualifier:@"land"]);
}

- (void)testCriteriaMeetIpad {

    id deviceUtilMock = OCMClassMock([MDDeviceUtil class]);
    OCMStub([deviceUtilMock isDevicePad]).andReturn(YES);
    OCMStub([deviceUtilMock deviceVersion]).andReturn(@"ipadmini1");
    
    MDDeviceResourceCriteria *deviceCriteria = [[MDDeviceResourceCriteria alloc] init];
    
    XCTAssert([deviceCriteria meetCriteriaWith:@"ipad"]);
    XCTAssert([deviceCriteria meetCriteriaWith:@"iPaD"]);

    XCTAssert(![deviceCriteria meetCriteriaWith:@"ipadair"]);
    XCTAssert(![deviceCriteria meetCriteriaWith:@"ipad2"]);
    
    XCTAssert(![deviceCriteria meetCriteriaWith:@"land"]);
    
    [deviceUtilMock stopMocking];
}

- (void)testCriteriaMeetIphone {
    
    id deviceUtilMock = OCMClassMock([MDDeviceUtil class]);
    OCMStub([deviceUtilMock isDevicePad]).andReturn(NO);
    OCMStub([deviceUtilMock deviceVersion]).andReturn(@"iphon6");

    MDDeviceResourceCriteria *deviceCriteria = [[MDDeviceResourceCriteria alloc] init];
    
    XCTAssert([deviceCriteria meetCriteriaWith:@"iphone"]);
    XCTAssert([deviceCriteria meetCriteriaWith:@"iphone6"]);
    
    XCTAssert([deviceCriteria meetCriteriaWith:@"IphonE"]);
    
    XCTAssert(![deviceCriteria meetCriteriaWith:@"iphone6plus"]);
    XCTAssert(![deviceCriteria meetCriteriaWith:@"IphonE6PLUS"]);
    
    [deviceUtilMock stopMocking];
}

- (void)testCriteriaOverride {
    
    id deviceUtilMock = OCMClassMock([MDDeviceUtil class]);
    OCMStub([deviceUtilMock isDevicePad]).andReturn(NO);
    OCMStub([deviceUtilMock deviceVersion]).andReturn(@"iphon6plus");

    MDDeviceResourceCriteria *deviceCriteria = [[MDDeviceResourceCriteria alloc] init];
    
    XCTAssert([deviceCriteria shouldOverrideQualifier:@"iphone" withQualifier:@"iphone6"]);
    XCTAssert([deviceCriteria shouldOverrideQualifier:@"iphone" withQualifier:@"iphone6plus"]);
    XCTAssert([deviceCriteria shouldOverrideQualifier:@"iphone6" withQualifier:@"iphone6plus"]);
    XCTAssert([deviceCriteria shouldOverrideQualifier:@"IphoNe6" withQualifier:@"ipHonE6plUs"]);

    XCTAssert(![deviceCriteria shouldOverrideQualifier:@"iphone6plus" withQualifier:@"iphone"]);
    XCTAssert(![deviceCriteria shouldOverrideQualifier:@"ipPHne6plus" withQualifier:@"iPHonE"]);
    
    [deviceUtilMock stopMocking];
}

@end
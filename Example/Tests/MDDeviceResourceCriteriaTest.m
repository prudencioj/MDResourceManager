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
#import "MDTestUtil.h"

@interface MDDeviceResourceCriteriaTest : XCTestCase

@end

@implementation MDDeviceResourceCriteriaTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testCriteriaRespondsTo {

    MDDeviceResourceCriteria *deviceCriteria = [[MDDeviceResourceCriteria alloc] init];

    XCTAssert([deviceCriteria respondsToQualifier:@"ipad"]);
    XCTAssert([deviceCriteria respondsToQualifier:@"iphone"]);
    
    XCTAssert([deviceCriteria respondsToQualifier:@"iphone6plus"]);
    
    XCTAssert(![deviceCriteria respondsToQualifier:@"land"]);
}

- (void)testCreteriaMeetIpad {
    
    [MDTestUtil mockDeviceModel:@"ipadmini1" isIpad:YES];

    MDDeviceResourceCriteria *deviceCriteria = [[MDDeviceResourceCriteria alloc] init];
    
    XCTAssert([deviceCriteria meetCriteriaWith:@"ipad"]);
    XCTAssert([deviceCriteria meetCriteriaWith:@"iPaD"]);

    XCTAssert(![deviceCriteria meetCriteriaWith:@"ipadair"]);
    XCTAssert(![deviceCriteria meetCriteriaWith:@"ipad2"]);
    
    XCTAssert(![deviceCriteria meetCriteriaWith:@"land"]);
}

- (void)testCriteriaMeetIphone {
    
    [MDTestUtil mockDeviceModel:@"iphone6" isIpad:NO];

    MDDeviceResourceCriteria *deviceCriteria = [[MDDeviceResourceCriteria alloc] init];
    
    XCTAssert([deviceCriteria meetCriteriaWith:@"iphone"]);
    XCTAssert([deviceCriteria meetCriteriaWith:@"iphone6"]);
    
    XCTAssert([deviceCriteria meetCriteriaWith:@"IphonE"]);
    
    XCTAssert(![deviceCriteria meetCriteriaWith:@"iphone6plus"]);
    XCTAssert(![deviceCriteria meetCriteriaWith:@"IphonE6PLUS"]);
}

- (void)testCriteriaOverride {
    
    [MDTestUtil mockDeviceModel:@"iphone6plus" isIpad:NO];

    MDDeviceResourceCriteria *deviceCriteria = [[MDDeviceResourceCriteria alloc] init];
    
    XCTAssert([deviceCriteria shouldOverrideQualifier:@"iphone" withQualifier:@"iphone6"]);
    XCTAssert([deviceCriteria shouldOverrideQualifier:@"iphone" withQualifier:@"iphone6plus"]);
    XCTAssert([deviceCriteria shouldOverrideQualifier:@"iphone6" withQualifier:@"iphone6plus"]);
    XCTAssert([deviceCriteria shouldOverrideQualifier:@"IphoNe6" withQualifier:@"ipHonE6plUs"]);

    XCTAssert(![deviceCriteria shouldOverrideQualifier:@"iphone6plus" withQualifier:@"iphone"]);
    XCTAssert(![deviceCriteria shouldOverrideQualifier:@"ipPHne6plus" withQualifier:@"iPHonE"]);
}

@end
//
//  MDDeviceOrientationResourceTest.m
//  MDResourceManager
//
//  Created by Joao Prudencio on 22/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "OCMock.h"
#import "MDDeviceUtil.h"
#import "MDOrientationResourceCriteria.h"

@interface MDDeviceOrientationResourceTest : XCTestCase

@end

@implementation MDDeviceOrientationResourceTest

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testCriteriaRespondsTo {
    
    MDOrientationResourceCriteria *orientationCriteria = [[MDOrientationResourceCriteria alloc] init];
    
    XCTAssert([orientationCriteria respondsToQualifier:@"land"]);
    XCTAssert([orientationCriteria respondsToQualifier:@"landscape"]);
    XCTAssert([orientationCriteria respondsToQualifier:@"port"]);
    XCTAssert([orientationCriteria respondsToQualifier:@"portrait"]);
    XCTAssert([orientationCriteria respondsToQualifier:@"poRTrAaIt"]);
    
    XCTAssert(![orientationCriteria respondsToQualifier:@"otherqualifier"]);
    XCTAssert(![orientationCriteria respondsToQualifier:@"otherportqualifier"]);
    XCTAssert(![orientationCriteria respondsToQualifier:@"otherland"]);
}

- (void)testCriteriaMeetPortrait {
    
    id deviceUtilMock = OCMClassMock([MDDeviceUtil class]);
    OCMStub([deviceUtilMock isDevicePortrait]).andReturn(YES);
    
    MDOrientationResourceCriteria *orientationCriteria = [[MDOrientationResourceCriteria alloc] init];
    
    XCTAssert([orientationCriteria meetCriteriaWith:@"port"]);
    XCTAssert([orientationCriteria meetCriteriaWith:@"portrait"]);
    
    XCTAssert(![orientationCriteria meetCriteriaWith:@"land"]);
    XCTAssert(![orientationCriteria meetCriteriaWith:@"landscape"]);
    
    [deviceUtilMock stopMocking];
}

- (void)testCriteriaMeetLandscape {
    
    id deviceUtilMock = OCMClassMock([MDDeviceUtil class]);
    OCMStub([deviceUtilMock isDevicePortrait]).andReturn(NO);
    
    MDOrientationResourceCriteria *orientationCriteria = [[MDOrientationResourceCriteria alloc] init];
    
    XCTAssert([orientationCriteria meetCriteriaWith:@"land"]);
    XCTAssert([orientationCriteria meetCriteriaWith:@"landscape"]);
    
    XCTAssert(![orientationCriteria meetCriteriaWith:@"port"]);
    XCTAssert(![orientationCriteria meetCriteriaWith:@"portrait"]);
    
    [deviceUtilMock stopMocking];
}

- (void)testCriteriaOverride {
    
    id deviceUtilMock = OCMClassMock([MDDeviceUtil class]);
    OCMStub([deviceUtilMock isDevicePortrait]).andReturn(NO);
    
    MDOrientationResourceCriteria *orientationCriteria = [[MDOrientationResourceCriteria alloc] init];
    
    XCTAssert(![orientationCriteria shouldOverrideQualifier:@"port" withQualifier:@"land"]);
    XCTAssert(![orientationCriteria shouldOverrideQualifier:@"land" withQualifier:@"port"]);
    
    [deviceUtilMock stopMocking];
}

@end
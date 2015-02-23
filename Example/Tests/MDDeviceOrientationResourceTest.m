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
#import "MDTestUtil.h"
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
    
    [MDTestUtil mockDeviceOrientationIsPortrait:YES];
    
    MDOrientationResourceCriteria *orientationCriteria = [[MDOrientationResourceCriteria alloc] init];
    
    XCTAssert([orientationCriteria meetCriteriaWith:@"port"]);
    XCTAssert([orientationCriteria meetCriteriaWith:@"portrait"]);
    
    XCTAssert(![orientationCriteria meetCriteriaWith:@"land"]);
    XCTAssert(![orientationCriteria meetCriteriaWith:@"landscape"]);
}

- (void)testCriteriaMeetLandscape {
    
    [MDTestUtil mockDeviceOrientationIsPortrait:NO];
    
    MDOrientationResourceCriteria *orientationCriteria = [[MDOrientationResourceCriteria alloc] init];
    
    XCTAssert([orientationCriteria meetCriteriaWith:@"land"]);
    XCTAssert([orientationCriteria meetCriteriaWith:@"landscape"]);
    
    XCTAssert(![orientationCriteria meetCriteriaWith:@"port"]);
    XCTAssert(![orientationCriteria meetCriteriaWith:@"portrait"]);
}

- (void)testCriteriaOverride {
    
    [MDTestUtil mockDeviceOrientationIsPortrait:NO];

    MDOrientationResourceCriteria *orientationCriteria = [[MDOrientationResourceCriteria alloc] init];
    
    XCTAssert(![orientationCriteria shouldOverrideQualifier:@"port" withQualifier:@"land"]);
    XCTAssert(![orientationCriteria shouldOverrideQualifier:@"land" withQualifier:@"port"]);
}

@end
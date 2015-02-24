//
//  MDResourceFilterTest.m
//  MDResourceManager
//
//  Created by Joao Prudencio on 22/02/15.
//  Copyright (c) 2015 Joao Prudencio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "MDResourceFilter.h"
#import "MDDeviceResourceCriteria.h"
#import "MDOrientationResourceCriteria.h"
#import "MDDeviceUtil.h"
#import "OCMock.h"

@interface MDResourceFilterTest : XCTestCase

@end

@implementation MDResourceFilterTest

- (void)testSimpleMatchSingleCriteriaMatchFilter {
    
    id deviceUtilMock = OCMClassMock([MDDeviceUtil class]);
    OCMStub([deviceUtilMock isDevicePad]).andReturn(NO);
    OCMStub([deviceUtilMock deviceVersion]).andReturn(@"iphone");
    
    // create filter only with device criteria
    MDResourceFilter *filter = [[MDResourceFilter alloc] initWithCriterias:@[[[MDDeviceResourceCriteria alloc] init]]];
    
    // setup two resources, one with iphone qualifier and another standard
    NSString *valueKey = @"key";
    MDResource *resource1 = [[MDResource alloc] initWithValues:@{valueKey:@(1)}
                                            resourceQualifiers:@[@"iphone"]];
    MDResource *resource2 = [[MDResource alloc] initWithValues:@{valueKey:@(2)}
                                            resourceQualifiers:@[]];
    NSArray *resources = @[resource1,resource2];
    
    // should match iphone resource
    MDResource *result2 = [filter filterResources:resources forKey:valueKey];
    XCTAssert([result2.values[valueKey] isEqual:@(1)]);
    [deviceUtilMock stopMocking];
}

- (void)testDefaultSingleCriteriaFilter {
    
    id deviceUtilMock = OCMClassMock([MDDeviceUtil class]);
    OCMStub([deviceUtilMock isDevicePad]).andReturn(YES);
    OCMStub([deviceUtilMock deviceVersion]).andReturn(@"ipad");
    
    // create filter only with device criteria
    MDResourceFilter *filter = [[MDResourceFilter alloc] initWithCriterias:@[[[MDDeviceResourceCriteria alloc] init]]];

    // setup two resources, one with iphone qualifier and another standard
    NSString *valueKey = @"key";
    MDResource *resource1 = [[MDResource alloc] initWithValues:@{valueKey:@(1)}
                                            resourceQualifiers:@[@"iphone"]];
    MDResource *resource2 = [[MDResource alloc] initWithValues:@{valueKey:@(2)}
                                            resourceQualifiers:@[]];
    NSArray *resources = @[resource1,resource2];
    
    // should match default resource
    MDResource *result1 = [filter filterResources:resources forKey:valueKey];
    XCTAssert([result1.values[valueKey] isEqual:@(2)]);
    [deviceUtilMock stopMocking];
}

- (void)testDefaultMultipleCriteriaFilter {
    
    id deviceUtilMock = OCMClassMock([MDDeviceUtil class]);
    OCMStub([deviceUtilMock isDevicePad]).andReturn(YES);
    OCMStub([deviceUtilMock deviceVersion]).andReturn(@"ipad");
    OCMStub([deviceUtilMock isDevicePortrait]).andReturn(YES);
    
    // create filter with multiple criterias
    MDResourceFilter *filter = [[MDResourceFilter alloc] initWithCriterias:@[[[MDDeviceResourceCriteria alloc] init],
                                                                             [[MDOrientationResourceCriteria alloc] init]]];
    
    // setup three resources with different qualifiers
    NSString *valueKey = @"key";
    MDResource *resource1 = [[MDResource alloc] initWithValues:@{valueKey:@(1)}
                                            resourceQualifiers:@[@"iphone"]];
    MDResource *resource2 = [[MDResource alloc] initWithValues:@{valueKey:@(2)}
                                            resourceQualifiers:@[@"iphone",@"landscape"]];
    MDResource *resource3 = [[MDResource alloc] initWithValues:@{valueKey:@(3)}
                                            resourceQualifiers:@[]];
    NSArray *resources = @[resource1,resource2,resource3];
    
    
    // should match default resource
    MDResource *result = [filter filterResources:resources forKey:valueKey];
    XCTAssert([result.values[valueKey] isEqual:@(3)]);
    
    [deviceUtilMock stopMocking];
}

- (void)testDefaultDeviceMultipleCriteriaFilter {
    
    id deviceUtilMock = OCMClassMock([MDDeviceUtil class]);
    OCMStub([deviceUtilMock isDevicePad]).andReturn(NO);
    OCMStub([deviceUtilMock deviceVersion]).andReturn(@"iphone");
    OCMStub([deviceUtilMock isDevicePortrait]).andReturn(YES);
    
    // create filter with multiple criterias
    MDResourceFilter *filter = [[MDResourceFilter alloc] initWithCriterias:@[[[MDDeviceResourceCriteria alloc] init],
                                                                             [[MDOrientationResourceCriteria alloc] init]]];
    
    // setup three resources with different qualifiers
    NSString *valueKey = @"key";
    MDResource *resource1 = [[MDResource alloc] initWithValues:@{valueKey:@(1)}
                                            resourceQualifiers:@[@"iphone"]];
    MDResource *resource2 = [[MDResource alloc] initWithValues:@{valueKey:@(2)}
                                            resourceQualifiers:@[@"iphone",@"landscape"]];
    MDResource *resource3 = [[MDResource alloc] initWithValues:@{valueKey:@(3)}
                                            resourceQualifiers:@[]];
    NSArray *resources = @[resource1,resource2,resource3];
    
    MDResource *result = [filter filterResources:resources forKey:valueKey];
    XCTAssert([result.values[valueKey] isEqual:@(1)]);
    
    [deviceUtilMock stopMocking];
}

- (void)testDoubleMatchMultipleCriteriaFilter {
    
    id deviceUtilMock = OCMClassMock([MDDeviceUtil class]);
    OCMStub([deviceUtilMock isDevicePad]).andReturn(NO);
    OCMStub([deviceUtilMock deviceVersion]).andReturn(@"iphone");
    OCMStub([deviceUtilMock isDevicePortrait]).andReturn(NO);
    
    // create filter with multiple criterias
    MDResourceFilter *filter = [[MDResourceFilter alloc] initWithCriterias:@[[[MDDeviceResourceCriteria alloc] init],
                                                                             [[MDOrientationResourceCriteria alloc] init]]];
    
    // setup three resources with different qualifiers
    NSString *valueKey = @"key";
    MDResource *resource1 = [[MDResource alloc] initWithValues:@{valueKey:@(1)}
                                            resourceQualifiers:@[@"iphone"]];
    MDResource *resource2 = [[MDResource alloc] initWithValues:@{valueKey:@(2)}
                                            resourceQualifiers:@[@"iphone",@"landscape"]];
    MDResource *resource3 = [[MDResource alloc] initWithValues:@{valueKey:@(3)}
                                            resourceQualifiers:@[]];
    
    // we want the more specific result, iphone AND landscape
    // send the resources in different orders to be sure is not order depedent
    
    MDResource *result1 = [filter filterResources:@[resource2,resource1,resource3]
                                          forKey:valueKey];
    XCTAssert([result1.values[valueKey] isEqual:@(2)]);
    
    MDResource *result2 = [filter filterResources:@[resource3,resource2,resource1]
                                          forKey:valueKey];
    XCTAssert([result2.values[valueKey] isEqual:@(2)]);
    
    MDResource *result3 = [filter filterResources:@[resource1,resource2,resource3]
                                           forKey:valueKey];
    XCTAssert([result3.values[valueKey] isEqual:@(2)]);
    
    [deviceUtilMock stopMocking];
}

- (void)testSecondaryCriteriaMultipleCriteriaFilter {
    
    id deviceUtilMock = OCMClassMock([MDDeviceUtil class]);
    OCMStub([deviceUtilMock isDevicePad]).andReturn(YES);
    OCMStub([deviceUtilMock deviceVersion]).andReturn(@"ipadmini");
    OCMStub([deviceUtilMock isDevicePortrait]).andReturn(NO);
    
    // create filter with multiple criterias
    MDResourceFilter *filter = [[MDResourceFilter alloc] initWithCriterias:@[[[MDDeviceResourceCriteria alloc] init],
                                                                             [[MDOrientationResourceCriteria alloc] init]]];
    
    // setup three resources with different qualifiers
    NSString *valueKey = @"key";
    MDResource *resource1 = [[MDResource alloc] initWithValues:@{valueKey:@(1)}
                                            resourceQualifiers:@[@"landscape"]];
    MDResource *resource2 = [[MDResource alloc] initWithValues:@{valueKey:@(2)}
                                            resourceQualifiers:@[@"ipad",@"portrait"]];
    MDResource *resource3 = [[MDResource alloc] initWithValues:@{valueKey:@(2)}
                                            resourceQualifiers:@[@"iphone4",@"portrait"]];
    
    // should match landscape constraint
    
    MDResource *result = [filter filterResources:@[resource1,resource2,resource3]
                                           forKey:valueKey];
    XCTAssert([result.values[valueKey] isEqual:@(1)]);
    
    [deviceUtilMock stopMocking];
}

- (void)testNoMatchMultipleCriteriaFilter {
    
    id deviceUtilMock = OCMClassMock([MDDeviceUtil class]);
    OCMStub([deviceUtilMock isDevicePad]).andReturn(NO);
    OCMStub([deviceUtilMock deviceVersion]).andReturn(@"iphone4");
    OCMStub([deviceUtilMock isDevicePortrait]).andReturn(NO);
    
    // create filter with multiple criterias
    MDResourceFilter *filter = [[MDResourceFilter alloc] initWithCriterias:@[[[MDDeviceResourceCriteria alloc] init],
                                                                             [[MDOrientationResourceCriteria alloc] init]]];
    
    // setup three resources with different qualifiers
    NSString *valueKey = @"key";
    MDResource *resource1 = [[MDResource alloc] initWithValues:@{valueKey:@(1)}
                                            resourceQualifiers:@[@"iphone6plus",@"portrait"]];
    MDResource *resource2 = [[MDResource alloc] initWithValues:@{valueKey:@(2)}
                                            resourceQualifiers:@[@"ipad",@"landscape"]];
    MDResource *resource3 = [[MDResource alloc] initWithValues:@{valueKey:@(2)}
                                            resourceQualifiers:@[@"iphone4",@"portrait"]];
    
    // we want the more specific result, iphone AND landscape
    // send the resources in different orders to be sure is not order depedent
    
    MDResource *result = [filter filterResources:@[resource1,resource2,resource3]
                                          forKey:valueKey];
    XCTAssert(!result.values[valueKey]);
    
    [deviceUtilMock stopMocking];
}

- (void)testFilterPerformance {
    
    id deviceUtilMock = OCMClassMock([MDDeviceUtil class]);
    OCMStub([deviceUtilMock isDevicePad]).andReturn(NO);
    OCMStub([deviceUtilMock deviceVersion]).andReturn(@"iphone6plus");
    OCMStub([deviceUtilMock isDevicePortrait]).andReturn(NO);
    
    // create filter with multiple criterias
    MDResourceFilter *filter = [[MDResourceFilter alloc] initWithCriterias:@[[[MDDeviceResourceCriteria alloc] init],
                                                                             [[MDOrientationResourceCriteria alloc] init]]];
    
    // some values to generate a huge data set
    NSInteger numberOfResources = 1000;
    NSInteger numberOfValuesPerResource = 1000;
    NSInteger correctIndex = numberOfResources/2;

    NSMutableArray *resources = @[].mutableCopy;

    for (NSInteger i = 0; i< numberOfResources; i++) {
     
        NSMutableDictionary *values = @{}.mutableCopy;
        
        for (NSInteger j = 0; j< numberOfValuesPerResource; j++) {
            
            NSString *key = [NSString stringWithFormat:@"%li",(long)j];
            values[key] = @(j);
        }
        
        NSMutableArray *resourceQualifiers = @[].mutableCopy;

        if (i == correctIndex) {
            
            [resourceQualifiers addObjectsFromArray:@[@"iphone6plus",@"landscape"]];
        } else if (i%2 == 0) {
            
            [resourceQualifiers addObjectsFromArray:@[@"ipad",@"landscape"]];
        } else {
            
            [resourceQualifiers addObjectsFromArray:@[@"iphone",@"portrait"]];
        }
        
        MDResource *resource = [[MDResource alloc] initWithValues:values
                                               resourceQualifiers:resourceQualifiers.copy];
        
        [resources addObject:resource];
    }
    
    [self measureBlock:^{
 
        NSString *key = [NSString stringWithFormat:@"%li",(long)correctIndex];
        MDResource *resource = [filter filterResources:resources
                                                forKey:key];
        
        XCTAssert(resource.values[key]);
        XCTAssert([resource.values[key] isEqual:@(correctIndex)]);
        XCTAssert([resource.resourceQualifiers containsObject:@"iphone6plus"]);
        XCTAssert([resource.resourceQualifiers containsObject:@"landscape"]);
    }];
    
    [deviceUtilMock stopMocking];
}

@end

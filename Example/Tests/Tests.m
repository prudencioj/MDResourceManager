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

@interface resourcesTests : XCTestCase

@property (nonatomic, strong) MDResourceManager *resourceManager;

@end

@implementation resourcesTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    NSArray *criterias = @[[[MDDeviceResourceCriteria alloc] init],
                           [[MDOrientationResourceCriteria alloc] init]];
    
    self.resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"dimensions"
                                                                                         criterias:criterias];
    
    [self.resourceManager loadResources];
    
    CGFloat dimension = [self.resourceManager floatForKey:@"labelFontSize"];

    NSLog(@"%f",dimension);
    
    XCTAssert(dimension == 45.0f, @"Pass");
}

- (void)testPerformanceExample {
    
    
}

@end

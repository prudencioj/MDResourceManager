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
}

- (void)tearDown {
    
    [super tearDown];
}

- (void)testResourceManager {
    
    NSArray *criterias = @[[[MDDeviceResourceCriteria alloc] init],
                           [[MDOrientationResourceCriteria alloc] init]];
    
    self.resourceManager = [[MDResourceManager alloc] initWithPrefixFileName:@"testresource"
                                                                                         criterias:criterias];
    
    [self.resourceManager loadResources];
    
    CGFloat dimension = [self.resourceManager floatForKey:@"size"];

    NSLog(@"%f",dimension);
    
    XCTAssert(dimension == 10.0f, @"Pass");
}

@end
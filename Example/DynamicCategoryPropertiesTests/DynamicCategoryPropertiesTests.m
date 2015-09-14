//
//  DynamicCategoryPropertiesTests.m
//  DynamicCategoryPropertiesTests
//
//  Created by Sam Dods on 30/12/2013.
//  Copyright (c) 2013 Sam Dods. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BasicObject+Properties.h"

@interface DynamicCategoryPropertiesTests : XCTestCase

@end

@implementation DynamicCategoryPropertiesTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBasic
{
    BasicObject *a = [BasicObject new];
    a.propertyA = @(1);
    
    XCTAssertEqualObjects(a.propertyA, @(1));
    XCTAssertNotEqualObjects(a.propertyA, @(2));
}

- (void)testTwoProperties
{
    BasicObject *a = [BasicObject new];
    a.propertyA = @(1);
    a.propertyB = @(2);
    
    XCTAssertEqualObjects(a.propertyA, @(1));
    XCTAssertEqualObjects(a.propertyB, @(2));
}

- (void)testTwoObjects
{
    BasicObject *a = [BasicObject new];
    BasicObject *b = [BasicObject new];
    a.propertyA = @(1);
    b.propertyA = @(2);
    
    XCTAssertEqualObjects(a.propertyA, @(1));
    XCTAssertEqualObjects(b.propertyA, @(2));
}

@end

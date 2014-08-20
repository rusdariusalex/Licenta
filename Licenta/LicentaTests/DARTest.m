//
//  DARTest.m
//  Foodie
//
//  Created by darius on 20/08/14.
//  Copyright (c) 2014 Darius Rus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DARFinishOrderViewController.h"

@interface DARTest : XCTestCase

@end

@implementation DARTest

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

- (void)testExample
{
    DARFinishOrderViewController *finishOrder = [[DARFinishOrderViewController alloc] init];
    
    float recommended = [finishOrder caloriesFromNumberOfSteps:83516
                                                           sex:@"M"
                                                        height:[NSNumber numberWithInt:173]
                                                        weight:[NSNumber numberWithInt:64]
                                                           age:[NSNumber numberWithInt:23]];
    
    XCTAssertEqual(roundf(recommended), 2838);

}

@end

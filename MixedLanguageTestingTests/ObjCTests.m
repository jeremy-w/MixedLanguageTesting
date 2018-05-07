//
//  ObjCTests.m
//  MixedLanguageTestingTests
//
//  Created by Jeremy W. Sherman on 2018-05-07.
//  Copyright © 2018 Jeremy W. Sherman. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ObjCTests : XCTestCase

@end

@implementation ObjCTests
- (void)testSwiftFromObjC {
    SomeSwiftClass *subject = [[SomeSwiftClass alloc] initWithSomeProperty:@"test"];
    XCTAssertEqualObjects(subject.someProperty, @"test");
}
@end

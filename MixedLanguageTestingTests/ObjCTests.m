//
//  ObjCTests.m
//  MixedLanguageTestingTests
//
//  Created by Jeremy W. Sherman on 2018-05-07.
//  Copyright © 2018 Jeremy W. Sherman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ObjCClassUsingSwiftClass.h"

@interface ObjCTests : XCTestCase

@end

@implementation ObjCTests
- (void)testSwiftFromObjC {
    ObjCClassUsingSwiftClass *subject = [ObjCClassUsingSwiftClass new];
    subject.swiftishProperty = [[SomeSwiftClass alloc] initWithSomeProperty:@"test"];
    XCTAssertNotNil(subject.swiftishProperty);
}
@end

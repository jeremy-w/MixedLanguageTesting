//
//  ObjCOnlyTests.m
//  ObjCOnlyTests
//
//  Created by Jeremy W. Sherman on 2018-05-07.
//  Copyright © 2018 Jeremy W. Sherman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ObjCClassUsingSwiftClass.h"

/**
 This is built into an Obj-C–only, rather than mixed-source, target.

 As such, it doesn't ever create its Derived Sources directory,
 because it doesn't need to build a Swift->Obj-C bridging header.

 That breaks the "back up two from that directory" path navigation
 that APP_TARGET_DERIVED_SOURCES_DIR relies on. :(
 */
@interface ObjCOnlyTests : XCTestCase

@end

@implementation ObjCOnlyTests
- (void)testSwiftFromObjC {
    ObjCClassUsingSwiftClass *subject = [ObjCClassUsingSwiftClass new];
    subject.swiftishProperty = [[SomeSwiftClass alloc] initWithSomeProperty:@"test"];
    XCTAssertNotNil(subject.swiftishProperty);
}
@end

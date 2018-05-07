//
//  MixedLanguageTestingTests.swift
//  MixedLanguageTestingTests
//
//  Created by Jeremy W. Sherman on 2018-05-07.
//  Copyright © 2018 Jeremy W. Sherman. All rights reserved.
//

import XCTest
@testable import MixedLanguageTesting

class MixedLanguageTestingTests: XCTestCase {
    func testCreatingSwiftFromSwift() {
        let subject = SomeSwiftClass(someProperty: "test")
        XCTAssertEqual(subject.someProperty, "test")
    }
}

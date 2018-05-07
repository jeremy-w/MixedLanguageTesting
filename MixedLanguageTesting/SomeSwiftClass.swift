//
//  SomeSwiftClass.swift
//  MixedLanguageTesting
//
//  Created by Jeremy W. Sherman on 2018-05-07.
//  Copyright © 2018 Jeremy W. Sherman. All rights reserved.
//

import Cocoa

@objc open
class SomeSwiftClass: NSObject {
    @objc
    let someProperty: String

    @objc
    init(someProperty: String) {
        self.someProperty = someProperty
    }
}

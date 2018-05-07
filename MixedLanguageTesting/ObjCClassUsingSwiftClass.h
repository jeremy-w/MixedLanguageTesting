//
//  ObjCClassUsingSwiftClass.h
//  MixedLanguageTesting
//
//  Created by Jeremy W. Sherman on 2018-05-07.
//  Copyright © 2018 Jeremy W. Sherman. All rights reserved.
//

/*
 Yes, this could be an @class decl instead.
 And that will likely be a workaround.

 But perhaps I can make #import unavoidable by doing things with enums next.
 */
#import "MixedLanguageTesting-Swift.h"

@interface ObjCClassUsingSwiftClass : NSObject
@property(nullable, nonatomic) SomeSwiftClass *swiftishProperty;
@end

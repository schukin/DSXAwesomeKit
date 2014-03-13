//
//  NSObject+DSXInspect.h
//  DSXAwesomeKit
//
//  Created by Dave Schukin on 3/13/14.
//  Copyright (c) 2014 Dave Schukin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DSXInspect)

+ (NSArray *)dsx_instanceVariableNames;
+ (NSArray *)dsx_classPropertyNames;
+ (NSArray *)dsx_classMethodNames;

@end

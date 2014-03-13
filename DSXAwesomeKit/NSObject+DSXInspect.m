//
//  NSObject+DSXInspect.m
//  DSXAwesomeKit
//
//  Created by Dave Schukin on 3/13/14.
//  Copyright (c) 2014 Dave Schukin. All rights reserved.
//

#import "NSObject+DSXInspect.h"
#import <objc/runtime.h>

@implementation NSObject (DSXInspect)

+ (NSArray *)dsx_instanceVariableNames
{
    u_int count;
    Ivar *classIvars = class_copyIvarList([self class], &count);
    NSMutableArray *iVarList = [NSMutableArray array];

    for (int i = 0; i < count; i++)
    {
        const char *ivarName = ivar_getName(classIvars[i]);
        [iVarList addObject:[NSString stringWithCString:ivarName encoding:NSUTF8StringEncoding]];
    }

    free(classIvars);
    return iVarList;
}

+ (NSArray *)dsx_classPropertyNames
{
    u_int count;
    objc_property_t *classProperties = class_copyPropertyList([self class], &count);
    NSMutableArray *propertyList = [NSMutableArray array];

    for (int i = 0; i < count; i++)
    {
        const char *propertyName = property_getName(classProperties[i]);
        [propertyList addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
    }

    free(classProperties);
    return propertyList;
}

+ (NSArray *)dsx_classMethodNames
{
    u_int count;
    Method *classMethods = class_copyMethodList([self class], &count);
    NSMutableArray *methodList = [NSMutableArray array];

    for (int i = 0; i < count; i++)
    {
        SEL methodNameSelector = method_getName(classMethods[i]);
        const char *methodName = sel_getName(methodNameSelector);
        [methodList addObject:[NSString stringWithCString:methodName encoding:NSUTF8StringEncoding]];
    }

    free(classMethods);
    return methodList;
}

@end

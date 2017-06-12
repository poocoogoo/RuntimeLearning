//
//  RLRuntime.m
//  RuntimeLearning
//
//  Created by SwiftZimu on 2017/6/8.
//  Copyright © 2017年 SwiftZimu. All rights reserved.
//

#import "RLRuntime.h"
#import "RLAccount.h"
#import <objc/runtime.h>

@implementation RLRuntime

- (void)classGetOperation {
    NSLog(@"RLAccount的 name 是 %s", class_getName([RLAccount class]));
    NSLog(@"RLAccount的 version 是 %d", class_getVersion([RLAccount class]));
    NSLog(@"RLAccount的 instance size 是 %ld", class_getInstanceSize([RLAccount class]));
    NSLog(@"RLAccount的 super_class 是 %@", class_getSuperclass([RLAccount class]));
}

- (void)copyIvarListOperation {
    unsigned int count = 0;
    Ivar *list = class_copyIvarList([RLAccount class], &count);
    for (unsigned int index = 0; index < count; index++) {
        Ivar ivar = list[index];
        const char *ivarName = ivar_getName(ivar);
        NSLog(@"RLAccount ivar: %s", ivarName);
    }
    free(list);
}

- (void)copyMethodListOperation {
    unsigned int count = 0;
    Method *list = class_copyMethodList([RLAccount class], &count);
    for (unsigned int index = 0; index < count; index++) {
        Method method = list[index];
        const char *selName = sel_getName(method_getName(method));
        const char *methodEncoding = method_getTypeEncoding(method);
        NSLog(@"RLAccount sel name: %s || type encoding: %s", selName, methodEncoding);
    }
    free(list);
}

- (void)copyPropertyListOperation {
    unsigned int count = 0;
    objc_property_t *list = class_copyPropertyList([RLAccount class], &count);
    for (unsigned int index = 0; index < count; index++) {
        objc_property_t property = list[index];
        const char *propertyName = property_getName(property);
        NSLog(@"RLAccount property name: %s", propertyName);
    }
    free(list);
}

- (void)copyProtocolListOperation {
    unsigned int count = 0;
    Protocol *protocol;
    Protocol * __unsafe_unretained *list = class_copyProtocolList([RLAccount class], &count);
    for (unsigned int index = 0; index < count; index++) {
        protocol = list[index];
        const char *protocolName = protocol_getName(protocol);
        NSLog(@"RLAccount protocol name: %s", protocolName);
    }
    free(list);
}

@end

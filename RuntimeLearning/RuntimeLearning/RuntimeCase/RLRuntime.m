//
//  RLRuntime.m
//  RuntimeLearning
//
//  Created by SwiftZimu on 2017/6/8.
//  Copyright © 2017年 SwiftZimu. All rights reserved.
//

#import "RLRuntime.h"
#import "RLAccount.h"
#import <CoreGraphics/CoreGraphics.h>
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

- (void)addMethodOperation {
    IMP imp = imp_implementationWithBlock( ^{
        NSLog(@"implementation block");
    });
    BOOL result = class_addMethod([RLAccount class], @selector(newMethodOperation), imp, nil);
    if (result) {
        [self copyMethodListOperation];
        RLAccount *account = [[RLAccount alloc] init];
        [account performSelector:@selector(newMethodOperation) withObject:nil];
    } else {
        NSLog(@"添加方法失败！");
    }

    imp_removeBlock(imp);
}

- (void)copyPropertyAttributeOperation {
    /*
    /// Defines a property attribute
    typedef struct {
        const char *name;           // The name of the attribute
        const char *value;          //The value of the attribute (usually empty)
    } objc_property_attribute_t;
    */
    objc_property_attribute_t attribute[] = {{ "T", "NSString"}, {"R", ""}};
    BOOL result = class_addProperty([RLAccount class], "newPropertyName", attribute, 2);
    if (result) {
        unsigned int count = 0;
        objc_property_t *list = class_copyPropertyList([RLAccount class], &count);
        for (unsigned int index = 0; index < count; index++) {
            objc_property_t property = list[index];
            const char *propertyName = property_getName(property);
            NSLog(@"RLAccount property name: %s", propertyName);
            /// 打印 property attributes
            unsigned int attributeCount = 0;
            objc_property_attribute_t *attributeList =
            property_copyAttributeList(property, &attributeCount);
            for (unsigned int j = 0; j < attributeCount; j++) {
                objc_property_attribute_t t = attributeList[j];
                NSLog(@"property attribute name: %s and value: %s", t.name, t.value);
            }
            free(attributeList);
        }
        free(list);
    } else {
        NSLog(@"添加属性失败");
    }
}

- (void)addPropertyOperation {
    /*
     /// Defines a property attribute
     typedef struct {
     const char *name;           // The name of the attribute
     const char *value;          //The value of the attribute (usually empty)
     } objc_property_attribute_t;
     */
    objc_property_attribute_t attribute[] = {{ "T", "NSString"}, {"R", ""}};
    BOOL result = class_addProperty([RLAccount class],
                                    "newPropertyName",
                                    attribute,
                                    2);
    if (result) {
        [self copyPropertyListOperation];
    } else {
        NSLog(@"添加属性失败");
    }
}

- (void)addProtocolOperation {
    Protocol *protocol = objc_allocateProtocol("Swift4Indexable");
    objc_registerProtocol(protocol);
    BOOL result = class_addProtocol([RLAccount class], protocol);
    if (result) {
        [self copyProtocolListOperation];
    } else {
        NSLog(@"添加协议失败");
    }
}

- (void)addIvarOperation {
    BOOL result = class_addIvar([RLAccount class],
                                "_email",
                                sizeof(NSString *),
                                log2(sizeof(NSString *)),
                                @encode(NSString *));
    if (result) {
        [self copyIvarListOperation];
    } else {
        NSLog(@"添加成员变量失败");
    }
}

- (void)addClassOperation {
    /// 动态的创建一个类 UserInfo 继承 NSObject
    Class userInfoClass = objc_allocateClassPair([NSObject class], "UserInfo", 0);
    class_addIvar(userInfoClass,
                "_email",
                sizeof(NSString *),
                log2(sizeof(NSString *)),
                @encode(NSString *));
    /// 注册 printLoginInfo方法
    SEL sel = sel_registerName("printLoginInfo");
    IMP imp = imp_implementationWithBlock(^(id self, SEL _cmd, id info) {
        NSLog(@"登录的帐号是：%@ , %@", [self valueForKey:@"email"], info);
    });
    class_addMethod(userInfoClass, sel, imp, "v@:@");
    /// 注册 UserInfo 类
    objc_registerClassPair(userInfoClass);
    id userInfoObject = [[userInfoClass alloc] init];
    /// 使用 KVO 设置变量值，以下是本人的个人邮箱，有技术问题欢迎联系。
    [userInfoObject setValue:@"swiftlang@163.com" forKey:@"email"];
    void (^block)(id self, SEL _cmd, id info) = imp_getBlock(imp);
    block(userInfoObject, sel, @"欢迎您学习 runtime 基础知识。");
    [userInfoObject performSelector:@selector(printLoginInfo) withObject:@"再次欢迎"];
    /// 销毁实例对象
    userInfoObject = nil;
    /// 销毁类对象
    objc_disposeClassPair(userInfoClass);
}

@end

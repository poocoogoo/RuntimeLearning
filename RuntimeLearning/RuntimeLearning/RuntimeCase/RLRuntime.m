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

@end

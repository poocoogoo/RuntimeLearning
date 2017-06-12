//
//  RLRuntime.h
//  RuntimeLearning
//
//  Created by SwiftZimu on 2017/6/8.
//  Copyright © 2017年 SwiftZimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RLRuntime : NSObject

- (void)classGetOperation;

- (void)copyIvarListOperation;

- (void)copyMethodListOperation;

- (void)copyPropertyListOperation;

- (void)copyProtocolListOperation;

@end

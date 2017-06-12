//
//  RLAccount.h
//  RuntimeLearning
//
//  Created by SwiftZimu on 2017/6/8.
//  Copyright © 2017年 SwiftZimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RLAccountDelegate <NSObject>

@optional
- (void)hello;

@end

@interface RLAccount : NSObject <RLAccountDelegate>

@property (nonatomic, strong, nullable) NSString *name;
@property (nonatomic) NSInteger age;

@end

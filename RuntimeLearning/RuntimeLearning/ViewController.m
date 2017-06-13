//
//  ViewController.m
//  RuntimeLearning
//
//  Created by SwiftZimu on 2017/6/8.
//  Copyright © 2017年 SwiftZimu. All rights reserved.
//

#import "ViewController.h"
#import "RLRuntime.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self runtimeCaseOperation];
}

- (void)runtimeCaseOperation {
    RLRuntime *runtimeObject = [[RLRuntime alloc] init];
    [runtimeObject addClassOperation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

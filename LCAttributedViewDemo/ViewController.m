//
//  ViewController.m
//  LCAttributedViewDemo
//
//  Created by George.tan on 2019/5/16.
//  Copyright © 2019年 LC. All rights reserved.
//

#import "ViewController.h"
#import "HNSignPrivacyAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [testBtn addTarget:self action:@selector(alertAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:testBtn];
    [testBtn setTitle:@"click" forState:UIControlStateNormal];
    [testBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    testBtn.frame = CGRectMake(100, 100, 100, 44);
    
}

- (void)alertAction
{
    HNSignPrivacyAlertView *privacyAlertView = [[HNSignPrivacyAlertView alloc] initWithCancleHandle:^{
       // 取消事件 doSomething
        NSLog(@"cancle ~~~~~~~~~~~~~~");
    } sureHandle:^{
       // 确定事件 doSomething
        NSLog(@"sure ~~~~~~~~~~~~~~");

    } readHandle:^{
        // 查阅事件 doSomething
        NSLog(@"read ~~~~~~~~~~~~~~");
    }];

    [privacyAlertView show];
}


@end

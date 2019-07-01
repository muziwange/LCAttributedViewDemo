//
//  ViewController.m
//  LCAttributedViewDemo
//
//  Created by George.tan on 2019/5/16.
//  Copyright © 2019年 LC. All rights reserved.
//

#import "ViewController.h"
#import "HNSignPrivacyAlertView.h"

#import "UILabel+LCHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 第一种方法
    //  textView
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [testBtn addTarget:self action:@selector(alertAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:testBtn];
    [testBtn setTitle:@"click" forState:UIControlStateNormal];
    [testBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    testBtn.frame = CGRectMake(100, 100, 100, 44);
    
    
    
    
    // 第二种, label 分类
    UILabel *lable = [[UILabel alloc] init];
    lable.numberOfLines = 0;
    lable.lineBreakMode = NSLineBreakByCharWrapping;
    [self.view addSubview:lable];
    lable.frame = CGRectMake(100, 200, 100, 100);
    
    NSString *clickContent = @"《隐私声明》";
    NSString *content = [[@"XXXX" stringByAppendingString:clickContent] stringByAppendingString:@", agree to it can login this app, please do it"];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:content];
    NSRange range = [content rangeOfString:clickContent];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor cyanColor] range:range];
    lable.attributedText = attributeStr;
    
    lable.clickHandle = ^(NSInteger index, NSAttributedString * _Nonnull attrString) {
        if (index >= range.location && index <= (range.location + range.length)) {
            
            NSLog(@"点击了 隐私声明 ");
        }
    };
    
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

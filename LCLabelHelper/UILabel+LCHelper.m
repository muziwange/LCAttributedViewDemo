//
//  UILabel+LCHelper.m
//  MaintainApp
//
//  Created by George.tan on 2019/6/21.
//  Copyright © 2019年 huawei. All rights reserved.
//

#import "UILabel+LCHelper.h"
#import <objc/runtime.h>
#import "LCLableCalculate.h"

NSString const *clickHandleKey = @"clickHandleKey";
NSString const *helperKey = @"helperKey";

@interface UILabel ()

@property (nonatomic, strong) LCLableCalculate *calculate; //!< 计算者

@end


@implementation UILabel (LCHelper)

#pragma mark - setter, getter
- (void)setClickHandle:(void (^)(NSInteger, NSAttributedString * _Nonnull))clickHandle
{
    // 关联对象,设置值
    objc_setAssociatedObject(self, &clickHandleKey, clickHandle, OBJC_ASSOCIATION_COPY);
    // 用户交互打开
    self.userInteractionEnabled = YES;
    
    LCLableCalculate *calculate = [[LCLableCalculate alloc] init];
    self.calculate = calculate;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}

- (void (^)(NSInteger, NSAttributedString * _Nonnull))clickHandle
{
    // 取值
    return objc_getAssociatedObject(self, &clickHandleKey);
}

- (void)setCalculate:(LCLableCalculate *)calculate
{
    // 关联对象,设置值
    objc_setAssociatedObject(self, &helperKey, calculate, OBJC_ASSOCIATION_RETAIN);
}

- (LCLableCalculate *)calculate
{
   return objc_getAssociatedObject(self, &helperKey);
}

#pragma mark - tapAction
- (void)tapAction:(UITapGestureRecognizer *)tapRecognizer
{
    if (![tapRecognizer.view isKindOfClass:[UILabel class]]) {
        NSLog(@"click is not a lable");
        return;
    }
  
    CGPoint point = [tapRecognizer locationInView:tapRecognizer.view];
    UILabel *lable = (UILabel *)tapRecognizer.view;
    
    __weak typeof(self) weakSelf = self;
    [self.calculate clickLocationInLable:lable locationPint:point completedHandle:^(NSInteger index, NSAttributedString * _Nonnull attrString) {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf.clickHandle) {
            strongSelf.clickHandle(index, attrString);
        }
        
    }];
}

@end

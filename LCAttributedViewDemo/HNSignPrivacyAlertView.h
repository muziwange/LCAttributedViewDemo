//
//  HNSignPrivacyAlertView.h
//  HomeNetwork
//
//  Created by George.tan on 2019/5/15.
//  Copyright © 2019年 HUAWEI. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClickAction)(void);

@interface HNSignPrivacyAlertView : UIView

/**
 隐私声明授权弹窗

 @param cancleHandle 取消事件
 @param sureHandle 确定事件
 @param readHandle 阅读事件
 @return view
 */
- (instancetype)initWithCancleHandle:(ClickAction)cancleHandle
                          sureHandle:(ClickAction)sureHandle
                          readHandle:(ClickAction)readHandle;

/**
 显示
 */
- (void)show;

/**
 移除
 */
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END

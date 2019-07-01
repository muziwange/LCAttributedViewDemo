//
//  LCLableCalculate.h
//  MaintainApp
//
//  Created by George.tan on 2019/6/21.
//  Copyright © 2019年 huawei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCLableCalculate : NSObject

/**
 获取label 点击 字符串 的位置

 @param lable lable
 @param point 手势点
 @param completedHandle 回调, -1 : 不在显示区域内
 */
- (void)clickLocationInLable:(UILabel *)lable locationPint:(CGPoint)point completedHandle:(void (^)(NSInteger ,NSAttributedString *))completedHandle;

@end

NS_ASSUME_NONNULL_END

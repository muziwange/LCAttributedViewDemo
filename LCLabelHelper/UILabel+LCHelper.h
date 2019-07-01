//
//  UILabel+LCHelper.h
//  MaintainApp
//
//  Created by George.tan on 2019/6/21.
//  Copyright © 2019年 huawei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (LCHelper)

//  点击回调, 不在区域内 index: -1
@property (nonatomic, copy) void (^clickHandle)(NSInteger, NSAttributedString *);

@end

NS_ASSUME_NONNULL_END

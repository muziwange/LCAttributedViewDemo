//
//  HNNoPastTextView.m
//  HomeNetwork
//
//  Created by George.tan on 2019/5/16.
//  Copyright © 2019年 HUAWEI. All rights reserved.
//

#import "HNNoPastTextView.h"

@implementation HNNoPastTextView

- (BOOL)canBecomeFirstResponder
{
    return NO;
}


//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
////    if (action == @selector(copy:)) { //禁止复制
////        return NO;
////    }
////    if (action == @selector(cut:)) {  //禁止剪切
////        return NO;
////    }
////    if (action == @selector(_share:)) {  //禁止共享
////        return NO;
////    }
////    if (action == @selector(select:)) {  //禁止选择
////        return NO;
////    }
////    if (action == @selector(selectAll:)) {  //禁止全选
////        return NO;
////    }
////    return [super canPerformAction:action withSender:sender];
//    UIMenuController *menuController = [UIMenuController sharedMenuController];
//    if (menuController)
//    {
//        [UIMenuController sharedMenuController].menuVisible = NO;
//    }
//    return NO;
//}

@end

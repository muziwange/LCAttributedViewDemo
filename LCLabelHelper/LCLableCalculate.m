//
//  LCLableCalculate.m
//  MaintainApp
//
//  Created by George.tan on 2019/6/21.
//  Copyright © 2019年 huawei. All rights reserved.
//

#import "LCLableCalculate.h"

@interface LCLableCalculate ()

@property (nonatomic , strong) NSTextStorage *storage; //!< textStorage
@property (nonatomic , strong) NSLayoutManager *manager; //!< 管理者
@property (nonatomic , strong) NSTextContainer *container; //!< 容器

@end


@implementation LCLableCalculate

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.storage = [[NSTextStorage alloc] init];
        self.manager = [[NSLayoutManager alloc] init];
        self.container = [[NSTextContainer alloc] init];
        [_storage addLayoutManager:_manager];
        [_manager addTextContainer:_container];
    }
    return self;
}


- (void)clickLocationInLable:(UILabel *)lable locationPint:(CGPoint)point completedHandle:(void (^)(NSInteger ,NSAttributedString *))completedHandle
{
    // 赋值
    _container.size = lable.bounds.size;
    _container.lineFragmentPadding = 0;
    _container.maximumNumberOfLines = lable.numberOfLines;
    _container.lineBreakMode = lable.lineBreakMode;
    
    NSRange contentRange = NSMakeRange(0, lable.attributedText.length);
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithAttributedString:lable.attributedText];
    [attr addAttribute:NSFontAttributeName value:lable.font range:contentRange];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = lable.textAlignment;
    [attr addAttribute:NSParagraphStyleAttributeName value:style range:contentRange];
    
    [_storage setAttributedString:attr];
    
    // 计算
    CGSize usedSize = [_manager usedRectForTextContainer:_container].size;
    point.y -= (CGRectGetHeight(lable.frame) - usedSize.height) / 2;
    NSUInteger glyphIndex = [_manager glyphIndexForPoint:point inTextContainer:_container];
    
    CGFloat pointSize = lable.font.pointSize;
    [_manager setAttachmentSize:CGSizeMake(pointSize, pointSize) forGlyphRange:NSMakeRange(lable.text.length - 1, 1)];
    
    NSAttributedString *subAttrString = [lable.attributedText attributedSubstringFromRange:NSMakeRange(glyphIndex, 1)];

    CGRect glyphRect = [_manager boundingRectForGlyphRange:NSMakeRange(glyphIndex, 1)
                                                     inTextContainer:_container];
    if (!CGRectContainsPoint(glyphRect, point)) {
        // 不在显示区域内
        if (completedHandle) {
            completedHandle(-1, nil);
        }
    }
    else
    {
        if (completedHandle) {
            completedHandle(glyphIndex, subAttrString);
        }
    }
    
}

@end

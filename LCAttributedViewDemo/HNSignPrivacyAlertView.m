//
//  HNSignPrivacyAlertView.m
//  HomeNetwork
//
//  Created by George.tan on 2019/5/15.
//  Copyright © 2019年 HUAWEI. All rights reserved.
//

#import "HNSignPrivacyAlertView.h"
#import "HNNoPastTextView.h"

//  屏幕宽度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
//  屏幕高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define RGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface HNSignPrivacyAlertView ()<UITextViewDelegate>

@property (nonatomic , strong) UIView *contentView; //!< 内容view
@property (nonatomic , assign) BOOL selStatus; //!< 选中状态
@property (nonatomic , strong) HNNoPastTextView *textView; //!< 内容view
@property (nonatomic , copy) ClickAction readHandle; //!<
@property (nonatomic , copy) ClickAction sureHandle; //!<
@property (nonatomic , copy) ClickAction cancleHandle; //!<
@property (nonatomic , strong) UIButton  *sureButton; //!<


@end

@implementation HNSignPrivacyAlertView


- (void)dealloc
{
    NSLog(@"HNSignPrivacyAlertView dealloc");
}

- (instancetype)initWithCancleHandle:(ClickAction)cancleHandle
                          sureHandle:(ClickAction)sureHandle
                          readHandle:(ClickAction)readHandle
{
    self = [super init];
    if (self) {
        self.selStatus = NO;
        
        self.readHandle = [readHandle copy];
        self.cancleHandle = [cancleHandle copy];
        self.sureHandle = [sureHandle copy];

        [self loadUI];
    }
    return self;
}

- (void)loadUI
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:.5];

    self.contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    CGFloat contentViewW = SCREEN_WIDTH - 50;
    _contentView.layer.cornerRadius = 5.0;
    _contentView.clipsToBounds = YES;
    _contentView.frame = CGRectMake(25, (SCREEN_HEIGHT-240)*.5, contentViewW, 240);
    
    // 提示label
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"提示";
    titleLabel.textColor = RGBHex(0x333333);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    [_contentView addSubview:titleLabel];
    titleLabel.frame = CGRectMake(0, 0, contentViewW, 44);
 
    
    // 取消按钮
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setTitleColor:RGBHex(0x999999) forState:UIControlStateNormal];
    [_contentView addSubview:cancleBtn];
    cancleBtn.frame = CGRectMake(0, _contentView.frame.size.height-44, contentViewW*.5, 44);
    
    // 确定按钮
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [sureBtn setTitleColor:RGBHex(0x999999) forState:UIControlStateDisabled];
    [_contentView addSubview:sureBtn];
    sureBtn.frame = CGRectMake(contentViewW*.5, _contentView.frame.size.height-44, contentViewW*.5, 44);
    sureBtn.enabled = _selStatus;
    self.sureButton = sureBtn;
    
    // 横线条
    UIView *horizontalLine = [[UIView alloc] init];
    horizontalLine.backgroundColor = RGBHex(0x999999);
    [_contentView addSubview:horizontalLine];
    horizontalLine.frame = CGRectMake(0, sureBtn.frame.origin.x, contentViewW, .5);
    
    // 竖线条
    UIView *verticalLine = [[UIView alloc] init];
    verticalLine.backgroundColor = RGBHex(0x999999);
    [_contentView addSubview:verticalLine];
    horizontalLine.frame = CGRectMake(contentViewW, sureBtn.frame.origin.x, contentViewW, .5);

    
    // 富文本
    self.textView = [[HNNoPastTextView alloc] init];
    _textView.delegate = self;
    _textView.scrollEnabled = NO;
    _textView.editable = NO;
    [_contentView addSubview:_textView];
    _textView.frame = CGRectMake(0, titleLabel.frame.size.height, contentViewW, _contentView.frame.size.height-titleLabel.frame.size.height- cancleBtn.frame.size.height);
    
    NSString *linkStr = @"《隐私声明》";
    NSString *title = [NSString stringWithFormat:@"%@有更新的胜利大街历史记录放开点击弗兰克斯解放东路看时间弗兰克斯建安费",linkStr];
    
    NSString *tipString = [NSString stringWithFormat:@"  %@",@"请阅读后同意,时间了咖啡店就流口水就考虑到福建省李开复到了开发商;了开发大道"];
    
    NSString *content = [NSString stringWithFormat:@"%@\n\n%@",title, tipString];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:content];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor cyanColor] range:NSMakeRange(0, linkStr.length)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:RGBHex(0x333333) range:NSMakeRange(linkStr.length, title.length -linkStr.length)];
    
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:15] range:NSMakeRange(0, title.length)];
    
    
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    [attributedStr addAttributes:@{NSFontAttributeName : font, NSForegroundColorAttributeName : RGBHex(0x666666)} range:NSMakeRange(content.length-tipString.length, tipString.length)];

    // 文字点击
    NSURL *url = [NSURL URLWithString:@"www.baidu.com"];
    [attributedStr addAttribute:NSLinkAttributeName value:url range:NSMakeRange(0, linkStr.length)];
    
    // 图片 login_agree_unselect login_agree_select
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    // https://www.jianshu.com/p/89ed22f50a9c 对齐方式参考
    attachment.bounds = CGRectMake(0, (font.lineHeight-25), 25, 25);
    
    
    // 图片还是有锯齿
//    UIImage *image = [UIImage imageNamed:@"login_agree_unselect"];
//    [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
//    attachment.image =  image;

    attachment.image =  [self scaleImage:[UIImage imageNamed:@"login_agree_unselect"] toSize:CGSizeMake(25, 25)] ;
    
    NSAttributedString *attachStr = [NSAttributedString attributedStringWithAttachment:attachment];
    [attributedStr insertAttributedString:attachStr atIndex:(content.length-tipString.length)];
    
    _textView.attributedText = attributedStr;
}

#pragma mark - UITextViewDelegate
/**
 *  点击图片触发代理事件
 */
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    NSLog(@"%@", textAttachment);
    self.selStatus = !self.selStatus;
    textAttachment.image = self.selStatus ? [self scaleImage:[UIImage imageNamed:@"login_agree_select"] toSize:CGSizeMake(25, 25)] :  [self scaleImage:[UIImage imageNamed:@"login_agree_unselect"] toSize:CGSizeMake(25, 25)];
    
    // 刷新图片
    [textView.layoutManager invalidateDisplayForCharacterRange:characterRange];
    
    self.sureButton.enabled = self.selStatus;
    
    return NO;
}

/**
 *  点击链接，触发代理事件
 */
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSLog(@"%@", URL);
    [self dismiss];

    if (self.readHandle) {
        _readHandle();
    }
    return NO;
}

// 取消
- (void)cancleAction
{
    [self dismiss];
    if (self.cancleHandle) {
        _cancleHandle();
    }
}

// 确定
- (void)sureAction
{
    [self dismiss];
    if (self.sureHandle) {
        _sureHandle();
    }
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

- (void)dismiss
{
    self.alpha = 0;
    [self removeFromSuperview];
}


// 缩放图片
- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size {
    if (image.size.width < size.width) {
        return image;
    }
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - setter
- (void)setSelStatus:(BOOL)selStatus
{
    @synchronized (self) {
        _selStatus = selStatus;
    }
}


@end

//
//  UIView+YSDisplayStatus.m
//  YSOA
//
//  Created by liuxy on 2019/7/12.
//  Copyright © 2019 YS. All rights reserved.
//

#import "UIView+YSDisplayStatus.h"
#import <Masonry.h>
#import "UIColor+YSOA.h"
#import "UIColor+YSUI.h"
#import <objc/runtime.h>


static  NSString * const kDisplayButtonBlock = @"kDisplayButtonBlock";
//static  NSString * const kDisplayStatusAgainBtnKey = @"kDisplayStatusAgainBtnKey";
//static  NSString * const kDisplayStatusTitleLabelKey = @"kDisplayStatusTitleLabelKey";

static  CGFloat const displayImageViewTag = 5900000;
static  CGFloat const displayAgainButtonTag = 5900001;
static  CGFloat const displaytitleLabelTag = 5900002;

@interface UIView()

@property (nonatomic, strong) UIImageView *displayImageView;

@property (nonatomic, strong) UIButton *againButton;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation UIView (YSDisplayStatus)


- (UIImageView *)displayImageView
{
    static dispatch_once_t onceToken;
    static UIImageView *displayImageView = nil;
    dispatch_once(&onceToken, ^{
        displayImageView = [[UIImageView alloc]init];
        displayImageView.tag = displayImageViewTag;
    });
    return displayImageView;
}

- (UILabel *)titleLabel
{
    static dispatch_once_t onceToken;
    static UILabel *titleLabel = nil;
    dispatch_once(&onceToken, ^{
        titleLabel = [[UILabel alloc]init];
        titleLabel.textColor = YSColorWithHex(0x000000);
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.tag = displayAgainButtonTag;
        titleLabel.textAlignment = NSTextAlignmentCenter;
    });
    return titleLabel;
}

- (UIButton *)againButton
{
    static dispatch_once_t onceToken;
    static UIButton *againButton = nil;
    dispatch_once(&onceToken, ^{
        againButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [againButton setTitle:@"重新加载" forState:UIControlStateNormal];
        againButton.backgroundColor = YSColorWithHex(0x3D7EFF);
        [againButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [againButton addTarget:self action:@selector(requestAgainAction:) forControlEvents:UIControlEventTouchUpInside];
        againButton.tag = displaytitleLabelTag;
        againButton.layer.cornerRadius = 5.f;
    });
    return againButton;
}

#pragma mark - public

- (void)showDisplayWith:(DisplayStatusType)type isHideAgainBtn:(BOOL)isHide 
{
    [self setupUI];
    switch (type) {
        case noNetwork:
            [self.displayImageView setImage:[UIImage imageNamed:@"report_daily_icon"]];
            self.titleLabel.text = @"无网";
            break;
        case noNetData:
            [self.displayImageView setImage:[UIImage imageNamed:@"report_daily_icon"]];
            self.titleLabel.text = @"无数据";
            break;
        case requestFailed:
            [self.displayImageView setImage:[UIImage imageNamed:@"report_daily_icon"]];
            self.titleLabel.text = @"加载失败";
            break;
        case requestAgain:
            [self.displayImageView setImage:[UIImage imageNamed:@"report_daily_icon"]];
            self.titleLabel.text = @"无数据点击重新加载";
            break;
        default:
            break;
    }
    self.againButton.hidden = isHide;
//    block(YES);
}

- (void)disDisplay
{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.tag == idx + displayImageViewTag){
            [obj removeFromSuperview];
        }
    }];
}

- (void)requestAgainAction:(UIButton *)sender
{
    if(self.btnActionBlock){
        self.btnActionBlock(sender);
    }
}

- (void)setupUI
{
    [self addSubview:self.displayImageView];
    self.displayImageView.contentMode = UIViewContentModeCenter;
    [self.displayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY).mas_offset( -90 );
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.left.mas_equalTo(self.mas_left).mas_offset(100);
        make.right.mas_equalTo(self.mas_right).mas_offset(-100);
        make.top.mas_equalTo(self.displayImageView.mas_bottom).mas_offset(12);
    }];

    
    [self addSubview:self.againButton];
    [self.againButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.left.mas_equalTo(self.mas_left).mas_offset(100);
        make.right.mas_equalTo(self.mas_right).mas_offset(-100);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(15);
    }];
    
}

#pragma mark - getSet
- (void)setBtnActionBlock:(RequestAgainBlock)btnActionBlock
{
    objc_setAssociatedObject(self, &kDisplayButtonBlock, btnActionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (RequestAgainBlock)btnActionBlock
{
    return objc_getAssociatedObject(self, &kDisplayButtonBlock);
}

@end

//
//  UIView+YSDisplayStatus.h
//  YSOA
//
//  Created by liuxy on 2019/7/12.
//  Copyright © 2019 YS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    noNetwork,
    noNetData,
    requestFailed,
    requestAgain,
} DisplayStatusType;

NS_ASSUME_NONNULL_BEGIN

typedef void(^RequestAgainBlock)(UIButton *sender);

@interface UIView (YSDisplayStatus)

@property (nonatomic, copy) RequestAgainBlock btnActionBlock;

/**
 展示

 @param type DisplayStatusType类型
 @param isHide 是否需要按钮
 */
- (void)showDisplayWith:(DisplayStatusType)type isHideAgainBtn:(BOOL)isHide;


/**
 消失
 */
- (void)disDisplay;


@end

NS_ASSUME_NONNULL_END

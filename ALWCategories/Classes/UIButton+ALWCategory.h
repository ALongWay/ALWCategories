//
//  UIButton+ALWCategory.h
//  ALWCategories
//
//  Created by lisong on 2017/5/8.
//  Copyright © 2017年 lisong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ALWButtonImageLocation) {
    ALWButtonImageLocationTop,
    ALWButtonImageLocationLeft,
    ALWButtonImageLocationBottom,
    ALWButtonImageLocationRight
};

@interface UIButton (ALWCategory)

/**
 *  设置按钮各种状态的显示图片
 *
 *  @param normalImg    常规图片
 *  @param highlightImg 高亮图片
 */
- (void)setButtonImageWithNormalImage:(UIImage *)normalImg highlightImage:(UIImage *)highlightImg;

/**
 *  设置按钮各种状态的背景图片
 *
 *  @param normalBgImg    normalBgImg
 *  @param highlightBgImg highlightBgImg
 */
- (void)setButtonBgImageWithNormalBgImage:(UIImage *)normalBgImg highlightBgImage:(UIImage *)highlightBgImg;

/**
 *  设置某状态的按钮标题文字
 *
 *  @param text  text description
 *  @param color color description
 *  @param font  font description
 *  @param state state description
 */
- (void)setButtonTitleWithText:(NSString*)text textColor:(UIColor*)color font:(UIFont *)font forState:(UIControlState)state;

/**
 *  设置按钮的各种状态的标题文字
 *
 *  @param text           text description
 *  @param font           font description
 *  @param normalColor    normalColor description
 *  @param highlightColor highlightColor description
 */
- (void)setButtonTitleWithText:(NSString *)text font:(UIFont *)font normalColor:(UIColor *)normalColor highlightColor:(UIColor *)highlightColor;

/**
 *  设置按钮的边框和圆角
 *
 *  @param color  边框颜色
 *  @param width  边框宽度
 *  @param radius 圆角半径
 */
- (void)setButtonBorderColor:(UIColor *)color borderWidth:(CGFloat)width cornerRadius:(CGFloat)radius;

/**
 *  当同时存在title和Image时候，用于调整两者的布局
 *
 *  @param midInset      中间间距
 *  @param imageLocation 图片相对方位
 */
- (void)resetButtonTitleAndImageLayoutWithMidInset:(CGFloat)midInset imageLocation:(ALWButtonImageLocation)imageLocation;

@end

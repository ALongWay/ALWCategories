//
//  UIView+ALWCategory.h
//  ALWCategories
//
//  Created by lisong on 2017/5/8.
//  Copyright © 2017年 lisong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ALWBlurEffectStyle) {
    ALWBlurEffectStyleExtraLight,
    ALWBlurEffectStyleLight,
    ALWBlurEffectStyleDark
};

@interface UIView (ALWCategory)

@property (nonatomic) CGFloat left;        ///<frame.origin.x.
@property (nonatomic) CGFloat top;         ///<frame.origin.y
@property (nonatomic) CGFloat right;       ///<frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///<frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///<frame.size.width.
@property (nonatomic) CGFloat height;      ///<frame.size.height.
@property (nonatomic) CGFloat centerX;     ///<center.x
@property (nonatomic) CGFloat centerY;     ///<center.y
@property (nonatomic) CGPoint origin;      ///<frame.origin.
@property (nonatomic) CGSize  size;        ///<frame.size.

#pragma mark -
/**
 设置边框，未修改masksToBounds属性；
 如果masksToBounds设置为YES，layer的content不为空，则可能出现离屏渲染；
 若只是简单设置背景，建议设置layer的backgroundColor属性；
 UIImageView的image需要裁剪圆角，请使用UIImage的裁剪相关方法。
 
 @param color 颜色
 @param width 宽度
 @param radius 圆角半径
 */
- (void)setLayerBorderColor:(UIColor *)color borderWidth:(CGFloat)width cornerRadius:(CGFloat)radius;

/**
 设置阴影
 
 @param color color description
 @param offset offset description
 @param radius radius description
 */
- (void)setLayerShadowColor:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius;

/**
 增加模糊效果

 @param style 效果类型
 @return 返回模糊效果的覆盖视图，可以从当前视图上移除
 */
- (UIView *)addBlurEffectWithStyle:(ALWBlurEffectStyle)style;

@end

//
//  UIImage+ALWCategory.h
//  ALWCategories
//
//  Created by lisong on 2017/5/9.
//  Copyright © 2017年 lisong. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - ALWMergeImage
@interface ALWMergeImage : NSObject

/**
 *  合并的图像
 */
@property (nonatomic, strong) UIImage *image;

/**
 *  合并的位置，设置image后默认使用CGRectMake(0, 0, image.size.width, image.size.height)
 */
@property (nonatomic, assign) CGRect mergeRect;

/**
 *  生成图像的合并对象，合并的rect默认使用CGRectMake(0, 0, image.size.width, image.size.height)
 *
 *  @param image 图像
 *
 *  @return 合并对象
 */
+ (ALWMergeImage *)getMergeImageWithImage:(UIImage *)image;

/**
 *  根据合并的rect，来生成图像的合并对象
 *
 *  @param image     图像
 *  @param mergeRect 合并的rect
 *
 *  @return 合并对象
 */
+ (ALWMergeImage *)getMergeImageWithImage:(UIImage *)image mergeRect:(CGRect)mergeRect;

@end

#pragma mark - UIImage (ALWCategory)
@interface UIImage (ALWCategory)

/**
 根据png图片的名称获取UIImage对象
 注：如下系列方法主要使用UIImage的imageWithContentsOfFile方法，在mainBundle目录下取资源，不在应用缓存中保留图像；
 但是无法直接获取到xcassets文件中的资源（建议使用imageNamed方法）；自定义bundle，需要指明bundle对象。

 @param name 图片名称
 @return return value description
 */
+ (UIImage *)getImagePNGWithName:(NSString *)name;

/**
 根据图片名称获取UIImage对象

 @param name 图片名称
 @return return value description
 */
+ (UIImage *)getImageWithName:(NSString *)name;

/**
 指定bundle的名称，获取UIImage对象

 @param name 图片名称
 @param bundleName 包名
 @return return value description
 */
+ (UIImage *)getImageWithName:(NSString *)name bundleName:(NSString *)bundleName;

/**
 指定bundle，获取UIImage对象

 @param name 图片名称
 @param bundle 资源包
 @return return value description
 */
+ (UIImage *)getImageWithName:(NSString *)name inBundle:(NSBundle *)bundle;

/**
 根据颜色，得到单位尺寸的纯色新图像

 @param color 颜色
 @return 单位尺寸的纯色新图像
 */
+ (UIImage *)getImageWithColor:(UIColor *)color;

/**
 根据颜色和尺寸，得到纯色新图像

 @param color 颜色
 @param size 尺寸
 @return return value description
 */
+ (UIImage *)getImageWithColor:(UIColor *)color size:(CGSize)size;

/**
 根据16进制的rgb值获取新图像

 @param rgbValue 16进制的rgb
 @return 单位尺寸的纯色新图像
 */
+ (UIImage *)getImageWithRGB:(uint32_t)rgbValue;

/**
 根据视图获取其截图的图像

 @param view view description
 @return return value description
 */
+ (UIImage *)getSnapshotWithView:(UIView *)view;

/**
 *  获取状态栏的单独截图
 *
 *  @return 状态栏截图
 */
+ (UIImage *)getStatusBarSnapshot;

/**
 *  全屏截图，但不包括状态栏
 *
 *  @return 全屏截图
 */
+ (UIImage *)getFullScreenSnapshotWithoutStatusBar;

/**
 *  全屏截图，包括状态栏
 *
 *  @return 全屏截图
 */
+ (UIImage *)getFullScreenSnapshotWithStatusBar;

/**
 将多张图像合并成一张图像，以第一张图为背景

 @param imageArray 图像数组
 @return return value description
 */
+ (UIImage *)getImageMergedWithOriginalImageArray:(NSArray<ALWMergeImage *> *)imageArray;

#pragma mark -

/// 根据比例获取等比缩放图像
- (UIImage *)scaleImageWithFactor:(CGFloat)factor;

/// 根据最大尺寸获取等比缩放图像
- (UIImage *)scaleImageWithMaxSize:(CGSize)maxSize;

/// 根据最大尺寸获取等比缩放后的尺寸
- (CGSize)getScaleSizeWithMaxSize:(CGSize)maxSize;

/// 根据填充尺寸获取填充后的图像
- (UIImage *)resizeImageWithFillSize:(CGSize)fillSize;

/// 根据边框获取裁剪的图像
- (UIImage *)clipImageWithFrame:(CGRect)frame;

/// 裁剪圆角图像
- (UIImage *)clipImageWithRoundCornerRadius:(CGFloat)radius;

/// 裁剪圆角图像，并添加边框
- (UIImage *)clipImageWithRoundCornerRadius:(CGFloat)radius
                                borderWidth:(CGFloat)borderWidth
                                borderColor:(UIColor *)borderColor;

/// 裁剪指定角的圆角图像，并添加边框
- (UIImage *)clipImageWithRoundCornerRadius:(CGFloat)radius
                                    corners:(UIRectCorner)corners
                                borderWidth:(CGFloat)borderWidth
                                borderColor:(UIColor *)borderColor;

/// 裁剪指定角的圆角图像，并添加边框，设置边框连接类型
- (UIImage *)clipImageWithRoundCornerRadius:(CGFloat)radius
                                    corners:(UIRectCorner)corners
                                borderWidth:(CGFloat)borderWidth
                                borderColor:(UIColor *)borderColor
                             borderLineJoin:(CGLineJoin)borderLineJoin;

/**
 根据给定贝塞尔曲线路径，裁剪图像

 @param bezierPath 贝塞尔曲线
 @return return value description
 */
- (UIImage *)clipImageWithBezierPath:(UIBezierPath *)bezierPath;

/**
 根据当前图像，生成二值化（黑白）图像，系数为0.5

 @param completion completion description
 */
- (void)generateBinaryzationImageWithCompletionBlock:(void (^)(UIImage *))completion;

/**
 根据当前图像，生成二值化（黑白）图像

 @param factor 二值化系数，在（0， 1）区间取值，值越大，黑色区域更多
 @param completion completion description
 */
- (void)generateBinaryzationImageWithFactor:(CGFloat)factor completionBlock:(void (^)(UIImage *))completion;

/**
 获取亮的模糊图像

 @return return value description
 */
- (UIImage *)applyLightEffect;

/**
 获取特别亮的模糊图像

 @return return value description
 */
- (UIImage *)applyExtraLightEffect;

/**
 获取暗的模糊图像

 @return return value description
 */
- (UIImage *)applyDarkEffect;

/**
 根据着色获取模糊图像

 @param tintColor 着色
 @return return value description
 */
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

/**
 根据自定义参数获取模糊图像

 @param blurRadius blurRadius description
 @param tintColor tintColor description
 @param saturationDeltaFactor saturationDeltaFactor description
 @param maskImage maskImage description
 @return return value description
 */
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end

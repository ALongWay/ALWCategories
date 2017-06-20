//
//  UIImage+ALWCategory.h
//  ALWCategories
//
//  Created by lisong on 2017/5/9.
//  Copyright © 2017年 lisong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ALWCategory)

/**
 根据png图片的名称获取UIImage对象

 @param name 不包含扩展名的名称
 @return return value description
 */
+ (UIImage *)getImagePNGWithName:(NSString *)name;

/**
 根据图片名称和扩展名获取UIImage对象

 @param name 不包含扩展名的名称
 @param type 图片扩展名
 @return return value description
 */
+ (UIImage *)getImageWithName:(NSString *)name type:(NSString *)type;

/**
 根据颜色，得到单位尺寸的纯色新图像

 @param color 颜色
 @return 单位尺寸的纯色新图像
 */
+ (UIImage *)getImageWithColor:(UIColor *)color;

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

@end

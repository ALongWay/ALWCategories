//
//  UIColor+ALWCategory.h
//  ALWCategories
//
//  Created by lisong on 2017/5/9.
//  Copyright © 2017年 lisong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ALWCategory)

/**
 根据十六进制RGB值获取颜色对象
 
 @param rgbValue 十六进制值(0xffffff)
 @return return value description
 */
+ (UIColor *)getColorWithRGB:(uint32_t)rgbValue;

+ (UIColor *)getColorWithRGBA:(uint32_t)rgbaValue;

+ (UIColor *)getColorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha;

/**
 根据rgb的灰度值（0~255）获取颜色对象

 @param red red description
 @param green green description
 @param blue blue description
 @return return value description
 */
+ (UIColor *)getColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

+ (UIColor *)getColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

@end

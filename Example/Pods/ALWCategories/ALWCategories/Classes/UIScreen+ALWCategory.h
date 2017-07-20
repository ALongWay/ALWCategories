//
//  UIScreen+ALWCategory.h
//  ALWCategories
//
//  Created by lisong on 2017/5/8.
//  Copyright © 2017年 lisong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (ALWCategory)

/**
 当前屏幕状态的宽度

 @return return value description
 */
+ (CGFloat)screenWidth;

/**
 当前屏幕状态的高度

 @return return value description
 */
+ (CGFloat)screenHeight;

/**
 竖屏状态的宽度

 @return return value description
 */
+ (CGFloat)screenPortraitWidth;

/**
 竖屏状态的高度

 @return return value description
 */
+ (CGFloat)screenPortraitHeight;

@end

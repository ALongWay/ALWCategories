//
//  UIScreen+ALWCategory.m
//  ALWCategories
//
//  Created by lisong on 2017/5/8.
//  Copyright © 2017年 lisong. All rights reserved.
//

#import "UIScreen+ALWCategory.h"

@implementation UIScreen (ALWCategory)

+ (CGFloat)screenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)screenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)screenPortraitWidth
{
    return MIN([self screenWidth], [self screenHeight]);
}

+ (CGFloat)screenPortraitHeight
{
    return MAX([self screenWidth], [self screenHeight]);
}

@end

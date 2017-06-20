//
//  UIImage+ALWCategory.m
//  ALWCategories
//
//  Created by lisong on 2017/5/9.
//  Copyright © 2017年 lisong. All rights reserved.
//

#import "UIImage+ALWCategory.h"

@implementation UIImage (ALWCategory)

+ (UIImage *)getImagePNGWithName:(NSString *)name;
{
    return [self getImageWithName:name type:@"png"];
}

+ (UIImage *)getImageWithName:(NSString *)name type:(NSString *)type
{
    NSString *fullName = name;
    NSInteger scale = [UIScreen mainScreen].scale;
    if (scale > 1) {
        fullName = [name stringByAppendingString:[NSString stringWithFormat:@"@%dx", (int)scale]];
    }
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fullName ofType:type];
    if (!filePath) {
        filePath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    }
    
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    return image;
}

+ (UIImage *)getImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)getImageWithRGB:(uint32_t)rgbValue
{
    UIColor *color = [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                    green:((rgbValue & 0xFF00) >> 8) / 255.0f
                     blue:(rgbValue & 0xFF) / 255.0f
                    alpha:1];
    
    return [self getImageWithColor:color];
}

+ (UIImage *)getSnapshotWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end

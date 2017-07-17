//
//  NSAttributedString+ALWCategory.h
//  ALWCategories
//
//  Created by lisong on 2017/5/8.
//  Copyright © 2017年 lisong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (ALWCategory)

#pragma mark -
+ (NSAttributedString *)attributedStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color;

+ (NSAttributedString *)attributedStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color lineHeight:(CGFloat)lineHeight;

#pragma mark -
- (CGSize)attributedStringSizeWithMaxWidth:(CGFloat)maxWidth;

- (CGSize)attributedStringSizeWithMaxHeight:(CGFloat)maxHeight;

@end

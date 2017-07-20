//
//  NSMutableAttributedString+ALWCategory.h
//  Pods
//
//  Created by lisong on 2017/7/13.
//
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (ALWCategory)

+ (NSMutableAttributedString *)mutableAttributedStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color;

+ (NSMutableAttributedString *)mutableAttributedStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color lineHeight:(CGFloat)lineHeight;

#pragma mark -
- (void)setTextColor:(UIColor *)color range:(NSRange)range;

- (void)setFont:(UIFont *)font range:(NSRange)range;

- (CGSize)mutableAttributedStringSizeWithMaxWidth:(CGFloat)maxWidth;

- (CGSize)mutableAttributedStringSizeWithMaxHeight:(CGFloat)maxHeight;

@end

//
//  NSString+ALWCategory.h
//  ALWCategories
//
//  Created by lisong on 2017/5/8.
//  Copyright © 2017年 lisong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (ALWCategory)

#pragma mark -
- (CGSize)stringSizeWithAttributes:(NSDictionary *)attributes;

- (CGSize)stringSizeWithAttributes:(NSDictionary *)attributes maxWidth:(CGFloat)maxWidth;

- (CGSize)stringSizeWithAttributes:(NSDictionary *)attributes maxHeight:(CGFloat)maxHeight;

- (CGSize)stringSizeWithFont:(UIFont *)font paragraphStyle:(NSParagraphStyle *)paragraphStyle maxWidth:(CGFloat)maxWidth;

- (CGSize)stringSizeWithFont:(UIFont *)font lineHeight:(CGFloat)lineHeight maxWidth:(CGFloat)maxWidth;

- (CGSize)stringSizeWithFont:(UIFont *)font;

- (CGSize)stringSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

- (CGSize)stringSizeWithFont:(UIFont *)font maxHeight:(CGFloat)maxHeight;

#pragma mark -

/**
 字符串字节长度，汉字占两个字节，字母占一个字节

 @return 字节长度
 */
- (NSUInteger)lengthOfBytes;

@end

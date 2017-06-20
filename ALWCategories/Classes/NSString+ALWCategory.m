//
//  NSString+ALWCategory.m
//  ALWCategories
//
//  Created by lisong on 2017/5/8.
//  Copyright © 2017年 lisong. All rights reserved.
//

#import "NSString+ALWCategory.h"

const static NSLineBreakMode kDefaultLineBreakMode = NSLineBreakByCharWrapping;
const static NSTextAlignment kDefaultTextAlignment = NSTextAlignmentLeft;

@implementation NSString (ALWCategory)

#pragma mark -
- (CGSize)stringSizeWithAttributes:(NSDictionary *)attributes
{
    CGSize size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return size;
}

- (CGSize)stringSizeWithAttributes:(NSDictionary *)attributes maxWidth:(CGFloat)maxWidth
{
    CGSize size = [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return size;
}

- (CGSize)stringSizeWithAttributes:(NSDictionary *)attributes maxHeight:(CGFloat)maxHeight
{
    CGSize size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return size;
}

- (CGSize)stringSizeWithFont:(UIFont *)font paragraphStyle:(NSParagraphStyle *)paragraphStyle maxWidth:(CGFloat)maxWidth
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:font forKey:NSFontAttributeName];
    [dic setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    return [self stringSizeWithAttributes:dic maxWidth:maxWidth];
}

- (CGSize)stringSizeWithFont:(UIFont *)font lineHeight:(CGFloat)lineHeight maxWidth:(CGFloat)maxWidth
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineHeightMultiple = lineHeight;
    paragraphStyle.maximumLineHeight = lineHeight;
    paragraphStyle.minimumLineHeight = lineHeight;
    paragraphStyle.lineBreakMode = kDefaultLineBreakMode;
    paragraphStyle.lineSpacing = 0;//行间距
    paragraphStyle.paragraphSpacing = 0;//段间距
    paragraphStyle.alignment = kDefaultTextAlignment;
    
    return [self stringSizeWithFont:font paragraphStyle:paragraphStyle maxWidth:maxWidth];
}

- (CGSize)stringSizeWithFont:(UIFont *)font
{
    NSDictionary *dic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    return [self stringSizeWithAttributes:dic];
}

- (CGSize)stringSizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth
{
    NSDictionary *dic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    return [self stringSizeWithAttributes:dic maxWidth:maxWidth];
}

- (CGSize)stringSizeWithFont:(UIFont *)font maxHeight:(CGFloat)maxHeight
{
    NSDictionary *dic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    return [self stringSizeWithAttributes:dic maxHeight:maxHeight];
}

#pragma mark - 
- (NSUInteger)lengthOfBytes
{
    NSUInteger bytesLength = 0;
    
    for (NSUInteger i = 0; i < self.length; i++) {        
        unichar uc = [self characterAtIndex: i];
        
        bytesLength += isascii(uc) ? 1 : 2;
    }
    
    return bytesLength;
}

@end

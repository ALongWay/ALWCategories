//
//  NSAttributedString+ALWCategory.m
//  ALWCategories
//
//  Created by lisong on 2017/5/8.
//  Copyright © 2017年 lisong. All rights reserved.
//

#import "NSAttributedString+ALWCategory.h"

@implementation NSAttributedString (ALWCategory)

#pragma mark -
+ (NSAttributedString *)attributedStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color
{
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:string
                                  attributes:@{NSFontAttributeName : font,
                                               NSForegroundColorAttributeName : color}];
    
    return attrStr;
}

+ (NSAttributedString *)attributedStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color lineHeight:(CGFloat)lineHeight
{
    if (!string) {
        return nil;
    }
    
    //设置文字段落
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineHeightMultiple = lineHeight;
    paragraphStyle.maximumLineHeight = lineHeight;
    paragraphStyle.minimumLineHeight = lineHeight;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = 0;//行间距
    paragraphStyle.paragraphSpacing = 0;//段间距
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:font forKey:NSFontAttributeName];
    [dic setObject:color forKey:NSForegroundColorAttributeName];
    [dic setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    NSAttributedString* attributedString = [[NSAttributedString alloc] initWithString:string attributes:dic];

    return attributedString;
}

#pragma mark -
- (CGSize)attributedStringSizeWithMaxWidth:(CGFloat)maxWidth
{
    CGSize size = [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    return size;
}

- (CGSize)attributedStringSizeWithMaxHeight:(CGFloat)maxHeight
{
    CGSize size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    return size;
}

@end

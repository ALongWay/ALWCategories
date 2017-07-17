//
//  NSMutableAttributedString+ALWCategory.m
//  Pods
//
//  Created by lisong on 2017/7/13.
//
//

#import "NSMutableAttributedString+ALWCategory.h"
#import "NSAttributedString+ALWCategory.h"

@implementation NSMutableAttributedString (ALWCategory)

+ (NSMutableAttributedString *)mutableAttributedStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string
                                                                  attributes:@{NSFontAttributeName : font,
                                                                               NSForegroundColorAttributeName : color}];
    
    return attrStr;
}

+ (NSMutableAttributedString *)mutableAttributedStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color lineHeight:(CGFloat)lineHeight
{
    NSMutableAttributedString *mutAttrStr = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithString:string font:font color:color lineHeight:lineHeight]];
    
    return mutAttrStr;
}

#pragma mark -
- (void)setTextColor:(UIColor *)color range:(NSRange)range
{
    [self addAttributes:@{NSForegroundColorAttributeName : color} range:range];
}

- (void)setFont:(UIFont *)font range:(NSRange)range
{
    [self addAttributes:@{NSFontAttributeName : font} range:range];
}

- (CGSize)mutableAttributedStringSizeWithMaxWidth:(CGFloat)maxWidth
{
    CGSize size = [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    return size;
}

- (CGSize)mutableAttributedStringSizeWithMaxHeight:(CGFloat)maxHeight
{
    CGSize size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    return size;
}
@end

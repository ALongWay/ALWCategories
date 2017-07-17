//
//  UIView+ALWCategory.m
//  ALWCategories
//
//  Created by lisong on 2017/5/8.
//  Copyright © 2017年 lisong. All rights reserved.
//

#import "UIView+ALWCategory.h"
#import "UIImage+ALWCategory.h"

@implementation UIView (ALWCategory)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

#pragma mark -
- (void)setLayerBorderColor:(UIColor *)color borderWidth:(CGFloat)width cornerRadius:(CGFloat)radius
{
    if (color) {
        [self.layer setBorderColor:color.CGColor];
    }
    
    [self.layer setBorderWidth:width];
    [self.layer setCornerRadius:radius];
}

- (void)setLayerShadowColor:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius
{
    if (color) {
        self.layer.shadowColor = color.CGColor;
    }
    
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = 1;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (UIView *)addBlurEffectWithStyle:(ALWBlurEffectStyle)style
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIBlurEffectStyle blurStyle;
        
        switch (style) {
            case ALWBlurEffectStyleExtraLight: {
                blurStyle = UIBlurEffectStyleExtraLight;
                break;
            }
            case ALWBlurEffectStyleLight: {
                blurStyle = UIBlurEffectStyleLight;
                break;
            }
            case ALWBlurEffectStyleDark: {
                blurStyle = UIBlurEffectStyleDark;
                break;
            }
        }
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:blurStyle];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = self.bounds;
        [self addSubview:effectView];
        
        return effectView;
    } else {
        UIImage *originalImage = [UIImage getSnapshotWithView:self];
        UIImage *blurImage;
        
        switch (style) {
            case ALWBlurEffectStyleExtraLight: {
                blurImage = [originalImage applyExtraLightEffect];
                break;
            }
            case ALWBlurEffectStyleLight: {
                blurImage = [originalImage applyLightEffect];
                break;
            }
            case ALWBlurEffectStyleDark: {
                blurImage = [originalImage applyDarkEffect];
                break;
            }
        }
        
        UIImageView *effectView = [[UIImageView alloc] initWithFrame:self.bounds];
        [effectView setImage:blurImage];
        
        [self addSubview:effectView];
        
        return effectView;
    }
}

@end

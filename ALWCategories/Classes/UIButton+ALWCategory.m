//
//  UIButton+ALWCategory.m
//  ALWCategories
//
//  Created by lisong on 2017/5/8.
//  Copyright © 2017年 lisong. All rights reserved.
//

#import "UIButton+ALWCategory.h"
#import <objc/runtime.h>

typedef void(^ResetTitleAndImageLayoutBlock)(void);

@interface UIButton (ALWCategoryPrivate)

@property (nonatomic, strong) ResetTitleAndImageLayoutBlock     resetTitleAndImageLayoutBlock;

@end

@implementation UIButton (ALWCategory)

+(void)load
{
    __weak typeof(self) weakSelf = self;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        [weakSelf swizzleOriginalSelector:@selector(layoutSubviews) withNewSelector:@selector(alw_layoutSubviews)];
    });
}

+(void)swizzleOriginalSelector:(SEL)originalSelector withNewSelector:(SEL)newSelector
{
    Class selfClass = [self class];
    
    Method originalMethod = class_getInstanceMethod(selfClass, originalSelector);
    Method newMethod = class_getInstanceMethod(selfClass, newSelector);
    
    IMP originalIMP = method_getImplementation(originalMethod);
    IMP newIMP = method_getImplementation(newMethod);
    
    //先用新的IMP加到原始SEL中
    BOOL addSuccess = class_addMethod(selfClass, originalSelector, newIMP, method_getTypeEncoding(newMethod));
    if (addSuccess) {
        class_replaceMethod(selfClass, newSelector, originalIMP, method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

- (void)alw_layoutSubviews
{
    [self alw_layoutSubviews];
    
    if (self.resetTitleAndImageLayoutBlock) {
        self.resetTitleAndImageLayoutBlock();
    }
}

#pragma mark -
- (ResetTitleAndImageLayoutBlock)resetTitleAndImageLayoutBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setResetTitleAndImageLayoutBlock:(ResetTitleAndImageLayoutBlock)resetTitleAndImageLayoutBlock
{
    objc_setAssociatedObject(self, @selector(resetTitleAndImageLayoutBlock), resetTitleAndImageLayoutBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -
- (void)setButtonImageWithNormalImage:(UIImage *)normalImg highlightImage:(UIImage *)highlightImg
{
    [self setImage:normalImg forState:UIControlStateNormal];
    [self setImage:highlightImg forState:UIControlStateHighlighted];
}

- (void)setButtonBgImageWithNormalBgImage:(UIImage *)normalBgImg highlightBgImage:(UIImage *)highlightBgImg
{
    [self setBackgroundImage:normalBgImg forState:UIControlStateNormal];
    [self setBackgroundImage:highlightBgImg forState:UIControlStateHighlighted];
}

- (void)setButtonTitleWithText:(NSString *)text textColor:(UIColor *)color font:(UIFont *)font forState:(UIControlState)state
{
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:text attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, color, NSForegroundColorAttributeName, nil]];
    [self setAttributedTitle:attrStr forState:state];
}

- (void)setButtonTitleWithText:(NSString *)text font:(UIFont *)font normalColor:(UIColor *)normalColor highlightColor:(UIColor *)highlightColor;
{
    [self setButtonTitleWithText:text textColor:normalColor font:font forState:UIControlStateNormal];
    [self setButtonTitleWithText:text textColor:highlightColor font:font forState:UIControlStateHighlighted];
}

- (void)setButtonBorderColor:(UIColor *)color borderWidth:(CGFloat)width cornerRadius:(CGFloat)radius
{
    [self.layer setMasksToBounds:YES];
    
    if (color) {
        [self.layer setBorderColor:color.CGColor];
    }
    
    [self.layer setBorderWidth:width];
    [self.layer setCornerRadius:radius];
}

- (void)resetButtonTitleAndImageLayoutWithMidInset:(CGFloat)midInset imageLocation:(ALWButtonImageLocation)imageLocation
{
    CGSize titleSize  = [self.titleLabel.attributedText boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;;
    CGSize imageSize = self.imageView.frame.size;
    
    __weak typeof(self) weakSelf = self;
    
    //因为UIButton在layoutSubviews时候，会重置titleLabel的frame，所以需要延迟调用block
    self.resetTitleAndImageLayoutBlock = ^{
        switch (imageLocation) {
            case ALWButtonImageLocationTop: {
                CGFloat imageOriginX = (weakSelf.frame.size.width - imageSize.width) / 2.0;
                CGFloat imageOriginY = (weakSelf.frame.size.height - titleSize.height - midInset - imageSize.height) / 2.0;
                weakSelf.imageEdgeInsets = UIEdgeInsetsMake(imageOriginY, imageOriginX, weakSelf.frame.size.height - imageOriginY - imageSize.height, imageOriginX);
                
                CGFloat titleOriginX = (weakSelf.frame.size.width - titleSize.width) / 2.0;
                CGFloat titleOriginY = imageOriginY + imageSize.height + midInset;
                weakSelf.titleLabel.frame = CGRectMake(titleOriginX, titleOriginY, titleSize.width, titleSize.height);
                [weakSelf.titleLabel setTextAlignment:NSTextAlignmentCenter];
                break;
            }
            case ALWButtonImageLocationLeft: {
                CGFloat imageOriginX = (weakSelf.frame.size.width - imageSize.width - midInset - titleSize.width) / 2.0;
                CGFloat imageOriginY = (weakSelf.frame.size.height - imageSize.height) /  2.0;
                weakSelf.imageEdgeInsets = UIEdgeInsetsMake(imageOriginY, imageOriginX, imageOriginY, weakSelf.frame.size.width - imageOriginX - imageSize.width);
                
                
                CGFloat titleOriginX = imageOriginX + imageSize.width + midInset;
                //横向时候，label的frame可以取较大范围
//                CGFloat titleOriginY = (weakSelf.height - titleSize.height) / 2.0;
//                weakSelf.titleLabel.frame = CGRectMake(titleOriginX, titleOriginY, titleSize.width, titleSize.height);
                weakSelf.titleLabel.frame = CGRectMake(titleOriginX, 0, weakSelf.frame.size.width - titleOriginX, weakSelf.frame.size.height);
                [weakSelf.titleLabel setTextAlignment:NSTextAlignmentLeft];
                break;
            }
            case ALWButtonImageLocationBottom: {
                CGFloat titleOriginX = (weakSelf.frame.size.width - titleSize.width) / 2.0;
                CGFloat titleOriginY = (weakSelf.frame.size.height - titleSize.height - midInset - imageSize.height) / 2.0;
                weakSelf.titleLabel.frame = CGRectMake(titleOriginX, titleOriginY, titleSize.width, titleSize.height);
                [weakSelf.titleLabel setTextAlignment:NSTextAlignmentCenter];
                
                CGFloat imageOriginX = (weakSelf.frame.size.width - imageSize.width) / 2.0;
                CGFloat imageOriginY = titleOriginY + titleSize.height + midInset;
                weakSelf.imageEdgeInsets = UIEdgeInsetsMake(imageOriginY, imageOriginX, weakSelf.frame.size.height - imageOriginY - imageSize.height, imageOriginX);
                break;
            }
                
            case ALWButtonImageLocationRight: {
                CGFloat titleOriginX = (weakSelf.frame.size.width - imageSize.width - midInset - titleSize.width) / 2.0;
                //横向时候，label的frame可以取较大范围
//                CGFloat titleOriginY = (weakSelf.height - titleSize.height) / 2.0;
//                weakSelf.titleLabel.frame = CGRectMake(titleOriginX, titleOriginY, titleSize.width, titleSize.height);
                weakSelf.titleLabel.frame = CGRectMake(0, 0, titleOriginX + titleSize.width, weakSelf.frame.size.height);
                [weakSelf.titleLabel setTextAlignment:NSTextAlignmentRight];
                
                CGFloat imageOriginX = titleOriginX + titleSize.width + midInset;
                CGFloat imageOriginY = (weakSelf.frame.size.height - imageSize.height) /  2.0;
                weakSelf.imageEdgeInsets = UIEdgeInsetsMake(imageOriginY, imageOriginX, imageOriginY, weakSelf.frame.size.width - imageOriginX - imageSize.width);
                break;
            }
        }
    };
    
    if (self.resetTitleAndImageLayoutBlock) {
        self.resetTitleAndImageLayoutBlock();
    }
}

@end

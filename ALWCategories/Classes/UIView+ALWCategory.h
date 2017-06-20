//
//  UIView+ALWCategory.h
//  ALWCategories
//
//  Created by lisong on 2017/5/8.
//  Copyright © 2017年 lisong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ALWCategory)

/**
 设置阴影

 @param color color description
 @param offset offset description
 @param radius radius description
 */
- (void)setLayerShadowColor:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius;

#pragma mark -
@property (nonatomic) CGFloat left;        ///<frame.origin.x.
@property (nonatomic) CGFloat top;         ///<frame.origin.y
@property (nonatomic) CGFloat right;       ///<frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///<frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///<frame.size.width.
@property (nonatomic) CGFloat height;      ///<frame.size.height.
@property (nonatomic) CGFloat centerX;     ///<center.x
@property (nonatomic) CGFloat centerY;     ///<center.y
@property (nonatomic) CGPoint origin;      ///<frame.origin.
@property (nonatomic) CGSize  size;        ///<frame.size.

@end

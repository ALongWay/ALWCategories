//
//  NSObject+ALWCategory.h
//  ALWCategories
//
//  Created by lisong on 2017/5/8.
//  Copyright © 2017年 lisong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ALWCategory)

/**
 *  交换方法
 *
 *  @param originalSelector 原方法
 *  @param newSelector      新方法
 */
+ (void)swizzleOriginalSelector:(SEL)originalSelector withNewSelector:(SEL)newSelector;

@end

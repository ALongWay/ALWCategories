//
//  NSObject+ALWCategory.m
//  ALWCategories
//
//  Created by lisong on 2017/5/8.
//  Copyright © 2017年 lisong. All rights reserved.
//

#import "NSObject+ALWCategory.h"
#import <objc/runtime.h>

@implementation NSObject (ALWCategory)

+ (void)swizzleOriginalSelector:(SEL)originalSelector withNewSelector:(SEL)newSelector
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

@end

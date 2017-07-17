#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ALWCategories.h"
#import "NSAttributedString+ALWCategory.h"
#import "NSMutableAttributedString+ALWCategory.h"
#import "NSObject+ALWCategory.h"
#import "NSString+ALWCategory.h"
#import "UIButton+ALWCategory.h"
#import "UIColor+ALWCategory.h"
#import "UIImage+ALWCategory.h"
#import "UIScreen+ALWCategory.h"
#import "UIView+ALWCategory.h"

FOUNDATION_EXPORT double ALWCategoriesVersionNumber;
FOUNDATION_EXPORT const unsigned char ALWCategoriesVersionString[];


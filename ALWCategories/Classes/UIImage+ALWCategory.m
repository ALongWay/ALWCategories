//
//  UIImage+ALWCategory.m
//  ALWCategories
//
//  Created by lisong on 2017/5/9.
//  Copyright © 2017年 lisong. All rights reserved.
//

#import "UIImage+ALWCategory.h"
#import <Accelerate/Accelerate.h>
#import <float.h>

#pragma mark - ALWMergeImage
@implementation ALWMergeImage

+ (ALWMergeImage *)getMergeImageWithImage:(UIImage *)image
{
    return [self getMergeImageWithImage:image mergeRect:CGRectMake(0, 0, image.size.width, image.size.height)];
}

+ (ALWMergeImage *)getMergeImageWithImage:(UIImage *)image mergeRect:(CGRect)mergeRect
{
    ALWMergeImage *model = [[ALWMergeImage alloc] init];
    model.image = image;
    model.mergeRect = mergeRect;
    
    return model;
}

@end

#pragma mark - UIImage (ALWCategory)
@implementation UIImage (ALWCategory)

+ (UIImage *)getImagePNGWithName:(NSString *)name;
{
    return [self getImageWithName:name];
}

+ (UIImage *)getImageWithName:(NSString *)name
{
    return [self getImageWithName:name inBundle:[NSBundle mainBundle]];
}

+ (UIImage *)getImageWithName:(NSString *)name bundleName:(NSString *)bundleName
{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:bundleName.stringByDeletingPathExtension ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    
    return [self getImageWithName:name inBundle:bundle];
}

+ (UIImage *)getImageWithName:(NSString *)name inBundle:(NSBundle *)bundle
{
    NSString *ext = name.pathExtension;
    NSArray *extArray;
    
    NSString *fullName = name;
    NSString *fileNameWithoutExt = name;
    
    if (ext && ![ext isEqualToString:@""]) {
        fileNameWithoutExt = name.stringByDeletingPathExtension;
        extArray = @[ext];
    }else{
        extArray = @[@"png", @"jpg", @"jpeg", @"bmp", @"webp"];
    }
    
    NSInteger scale = [UIScreen mainScreen].scale;
    if (scale > 1) {
        fullName = [fileNameWithoutExt stringByAppendingString:[NSString stringWithFormat:@"@%dx", (int)scale]];
    }
    
    NSString *filePath;
    
    for (NSString *tempExt in extArray) {
        filePath = [bundle pathForResource:fullName ofType:tempExt];
        
        if (filePath) {
            break;
        }else{
            if (![fileNameWithoutExt isEqualToString:fullName]) {
                filePath = [bundle pathForResource:fileNameWithoutExt ofType:tempExt];
                
                if (filePath) {
                    break;
                }
            }
        }
    }
    
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    
    return image;
}

+ (UIImage *)getImageWithColor:(UIColor *)color
{
    return [self getImageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)getImageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)getImageWithRGB:(uint32_t)rgbValue
{
    UIColor *color = [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                    green:((rgbValue & 0xFF00) >> 8) / 255.0f
                     blue:(rgbValue & 0xFF) / 255.0f
                    alpha:1];
    
    return [self getImageWithColor:color];
}

+ (UIImage *)getSnapshotWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)getStatusBarSnapshot
{
    UIApplication *app = [UIApplication sharedApplication];
    //私有变量得到状态栏
    UIView *statusBar = [app valueForKeyPath:@"statusBar"];
    
    UIGraphicsBeginImageContextWithOptions(statusBar.bounds.size, NO, 0.0);
    [statusBar.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)getFullScreenSnapshotWithoutStatusBar
{
    return [self getSnapshotWithView:[UIApplication sharedApplication].keyWindow];
}

+ (UIImage *)getFullScreenSnapshotWithStatusBar
{
    UIImage *statusBarImage = [self getStatusBarSnapshot];
    UIImage *bgImage = [self getFullScreenSnapshotWithoutStatusBar];
    
    ALWMergeImage *mergeImage1 = [ALWMergeImage getMergeImageWithImage:bgImage];
    ALWMergeImage *mergeImage2 = [ALWMergeImage getMergeImageWithImage:statusBarImage];
    
    UIImage *newImage = [self getImageMergedWithOriginalImageArray:@[mergeImage1, mergeImage2]];
    
    return newImage;
}

+ (UIImage *)getImageMergedWithOriginalImageArray:(NSArray<ALWMergeImage *> *)imageArray
{
    if (!imageArray
        || imageArray.count == 0) {
        return nil;
    }
    
    ALWMergeImage *firstMergeImage = [imageArray firstObject];
    
    //将第一张图作为背景放置
    CGRect firstMergeRect = firstMergeImage.mergeRect;
    firstMergeRect.origin = CGPointZero;
    firstMergeImage.mergeRect = firstMergeRect;
    
    UIGraphicsBeginImageContextWithOptions(firstMergeImage.mergeRect.size, NO, 0.0);
    
    for (ALWMergeImage *mergeImage in imageArray) {
        [mergeImage.image drawInRect:mergeImage.mergeRect];
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark -
- (UIImage *)scaleImageWithFactor:(CGFloat)factor
{
    CGSize newSize = CGSizeMake(self.size.width * factor, self.size.height * factor);
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)scaleImageWithMaxSize:(CGSize)maxSize
{
    CGSize newSize = [self getScaleSizeWithMaxSize:maxSize];
    
    return [self scaleImageWithFactor:newSize.width / self.size.width];
}

- (CGSize)getScaleSizeWithMaxSize:(CGSize)maxSize
{
    CGSize imageSize = self.size;
    
    CGFloat scale = maxSize.width / imageSize.width;
    CGFloat newWidth = maxSize.width;
    CGFloat newHeight = scale * imageSize.height;
    
    if (newHeight > maxSize.height) {
        scale = maxSize.height / imageSize.height;
        newHeight = maxSize.height;
        newWidth = scale * imageSize.width;
    }
    
    return CGSizeMake(newWidth, newHeight);
}

- (UIImage *)resizeImageWithFillSize:(CGSize)fillSize
{
    UIGraphicsBeginImageContextWithOptions(fillSize, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, fillSize.width, fillSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)clipImageWithFrame:(CGRect)frame
{
    CGImageRef cgimageRef = CGImageCreateWithImageInRect(self.CGImage, frame);
    UIImage *newImage = [UIImage imageWithCGImage:cgimageRef];
    CGImageRelease(cgimageRef);
    
    return newImage;
}

- (UIImage *)clipImageWithRoundCornerRadius:(CGFloat)radius
{
    return [self clipImageWithRoundCornerRadius:radius borderWidth:0 borderColor:nil];
}

- (UIImage *)clipImageWithRoundCornerRadius:(CGFloat)radius
                                borderWidth:(CGFloat)borderWidth
                                borderColor:(UIColor *)borderColor
{
    return [self clipImageWithRoundCornerRadius:radius
                                        corners:UIRectCornerAllCorners
                                    borderWidth:borderWidth
                                    borderColor:borderColor];
}

- (UIImage *)clipImageWithRoundCornerRadius:(CGFloat)radius
                                    corners:(UIRectCorner)corners
                                borderWidth:(CGFloat)borderWidth
                                borderColor:(UIColor *)borderColor
{
    return [self clipImageWithRoundCornerRadius:radius
                                        corners:corners
                                    borderWidth:borderWidth
                                    borderColor:borderColor
                                 borderLineJoin:kCGLineJoinMiter];
}

- (UIImage *)clipImageWithRoundCornerRadius:(CGFloat)radius
                                    corners:(UIRectCorner)corners
                                borderWidth:(CGFloat)borderWidth
                                borderColor:(UIColor *)borderColor
                             borderLineJoin:(CGLineJoin)borderLineJoin
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    [path closePath];

    CGContextSaveGState(context);
    [path addClip];
    [self drawInRect:rect];
    CGContextRestoreGState(context);
    
    if (borderWidth > 0) {
        UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth / 2.0, borderWidth / 2.0) byRoundingCorners:corners cornerRadii:CGSizeMake(radius - borderWidth / 2.0, radius - borderWidth / 2.0)];
        [borderPath closePath];
        
        borderPath.lineWidth = borderWidth;
        borderPath.lineJoinStyle = borderLineJoin;
        
        if (borderColor) {
            [borderColor setStroke];
        }
        
        [borderPath stroke];
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)clipImageWithBezierPath:(UIBezierPath *)bezierPath
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    [bezierPath closePath];

    CGContextSaveGState(context);
    [bezierPath addClip];
    [self drawInRect:rect];
    CGContextRestoreGState(context);

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)generateBinaryzationImageWithCompletionBlock:(void (^)(UIImage *))completion
{
    return [self generateBinaryzationImageWithFactor:0.5 completionBlock:completion];
}

- (void)generateBinaryzationImageWithFactor:(CGFloat)factor completionBlock:(void (^)(UIImage *))completion
{
    if (factor < 0) {
        factor = 0;
    }else if (factor > 1) {
        factor = 1;
    }
    
    CGFloat criticalValue = 256 * factor;
    
    CGImageRef imageRef = self.CGImage;
    
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    bool shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    CGColorRenderingIntent intent = CGImageGetRenderingIntent(imageRef);
    
    CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
    
    CFDataRef data = CGDataProviderCopyData(dataProvider);
    
    UInt8 *buffer = (UInt8*)CFDataGetBytePtr(data);
    
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            UInt8 *tmp = buffer + y * bytesPerRow + x * 4;
            
            UInt8 red,green,blue;
            red = *(tmp + 0);
            green = *(tmp + 1);
            blue = *(tmp + 2);
            
            if (red + green + blue > criticalValue * 3) {
                *(tmp + 0) = 255;
                *(tmp + 1) = 255;
                *(tmp + 2) = 255;
            }else{
                *(tmp + 0) = 0;
                *(tmp + 1) = 0;
                *(tmp + 2) = 0;
            }
            
            //其他处理效果
            //            UInt8 brightness;
            //            switch (type) {
            //                case 1:
            //                    brightness = (77 * red + 28 * green + 151 * blue) / 256;
            //                    *(tmp + 0) = brightness;
            //                    *(tmp + 1) = brightness;
            //                    *(tmp + 2) = brightness;
            //                    break;
            //                case 2:
            //                    *(tmp + 0) = red;
            //                    *(tmp + 1) = green * 0.7;
            //                    *(tmp + 2) = blue * 0.4;
            //                    break;
            //                case 3:
            //                    *(tmp + 0) = 255 - red;
            //                    *(tmp + 1) = 255 - green;
            //                    *(tmp + 2) = 255 - blue;
            //                    break;
            //                default:
            //                    *(tmp + 0) = red;
            //                    *(tmp + 1) = green;
            //                    *(tmp + 2) = blue;
            //                    break;
            //            }
        }
    }
    
    CFDataRef effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
    CGDataProviderRef effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    
    CGImageRef effectedCgImage = CGImageCreate(width, height,
                                               bitsPerComponent, bitsPerPixel, bytesPerRow,
                                               colorSpace, bitmapInfo, effectedDataProvider,
                                               NULL, shouldInterpolate, intent);
    
    UIImage *effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
    
    CGImageRelease(effectedCgImage);
    
    CFRelease(effectedDataProvider);
    
    CFRelease(effectedData);
    
    CFRelease(data);
    
    if (completion) {
        completion(effectedImage);
    }
}

- (UIImage *)applyLightEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    return [self applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyExtraLightEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:0.97 alpha:0.82];
    return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyDarkEffect
{
    UIColor *tintColor = [UIColor colorWithWhite:0.11 alpha:0.73];
    return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor
{
    const CGFloat EffectColorAlpha = 0.6;
    UIColor *effectColor = tintColor;
    NSInteger componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);
    if (componentCount == 2) {
        CGFloat b;
        if ([tintColor getWhite:&b alpha:NULL]) {
            effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
        }
    }
    else {
        CGFloat r, g, b;
        if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
            effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
        }
    }
    return [self applyBlurWithRadius:10 tintColor:effectColor saturationDeltaFactor:-1.0 maskImage:nil];
}


- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage
{
    // Check pre-conditions.
    if (self.size.width < 1 || self.size.height < 1) {
        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    if (!self.CGImage) {
        NSLog (@"*** error: image must be backed by a CGImage: %@", self);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            uint32_t radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // Draw effect image.
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // Add in color tint.
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

@end

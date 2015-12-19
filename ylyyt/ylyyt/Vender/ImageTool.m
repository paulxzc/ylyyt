//
//  ImageTool.m
//  ylyyt
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ImageTool.h"
#import <QuartzCore/QuartzCore.h>

@implementation ImageTool

static ImageTool *_sharedImageTool = nil;

//返回单例的静态方法
+ (ImageTool *)shareTool{
    //确保线程安全
    @synchronized(self) {
        //确保只返回一个实例
        if(_sharedImageTool == nil){
            _sharedImageTool = [[ImageTool alloc] init];
        }
    }
    return _sharedImageTool;
}

- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

//返回特定尺寸的UIImage，image参数为图片，size为要设定的图片大小
- (UIImage *)resizeImageToSize:(CGSize)size sizeOfImage:(UIImage *)image{
    UIGraphicsBeginImageContext(size);
    //获取上下文内容
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, 0.0, size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);
    //重绘image
    CGContextDrawImage(ctx, CGRectMake(0.0f, 0.0f, size.width, size.height), image.CGImage);
    //根据指定的size大小得到新的image
    UIImage *scaled = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaled;
}

//在指定的视图内进行截屏操作，返回截屏后的图片
- (UIImage *)imageWithScreenContentsInView:(UIView *)view{
    //根据屏幕大小，获取上下文
    UIGraphicsBeginImageContext(CGSizeMake(0.2*SCREEN_WIDTH, 0.125*SCREEN_HEIGHT));
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return viewImage;
}
@end

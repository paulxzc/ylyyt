//
//  ImageTool.h
//  ylyyt
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageTool : NSObject

//返回单例的静态方法
+ (ImageTool *)shareTool;

//返回特定尺寸的UIImage，image参数为图片，size为要设定的图片大小
- (UIImage *)resizeImageToSize:(CGSize)size sizeOfImage:(UIImage *)image;

//在指定的视图内进行截屏操作，返回截屏后的图片
- (UIImage *)imageWithScreenContentsInView:(UIView *)view;

@end

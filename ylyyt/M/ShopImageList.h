//
//  ShopImageList.h
//  ylyyt
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopImageList : NSObject
{
    NSString *_idd;
    NSString *_imageName;
    NSString *_imageDescribe;
    NSString *_shopId;
    NSString *_imageCatalog;
    NSString *_imageAdmin;
}

@property (nonatomic, strong) NSString *idd;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *imageDescribe;
@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, strong) NSString *imageCatalog;
@property (nonatomic, strong) NSString *imageAdmin;

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (ShopImageList *)shopImageListWithDic:(NSDictionary *)dic;

@end

//
//  ShopInfoForItemShow.h
//  ylyyt
//
//  Created by apple on 15/11/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopInfoForItemShow : NSObject
{
    NSString *_idd;
    NSString *_shopId;
    NSString *_shopName;
    NSString *_shopAdmin;
    NSString *_shopPhone;
    NSString *_shopLogo;
    NSString *_shopAddress;
    NSString *_shopPassword;
    NSString *_createDate;
    NSString *_imageName;
    NSString *_itemName;
    NSString *_itemPrice;
    NSString *_itemDescribe;
}

@property (nonatomic, strong) NSString *idd;
@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *shopAdmin;
@property (nonatomic, strong) NSString *shopPhone;
@property (nonatomic, strong) NSString *shopLogo;
@property (nonatomic, strong) NSString *shopAddress;
@property (nonatomic, strong) NSString *shopPassword;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *itemPrice;
@property (nonatomic, strong) NSString *itemDescribe;

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (ShopInfoForItemShow *)shopInfoForItemShowWithDic:(NSDictionary *)dic;
@end

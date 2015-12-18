//
//  ShopInfo.h
//  ylyyt
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopInfo : NSObject
{
    NSString *_idd;
    NSString *_shopId;
    NSString *_shopName;
    NSString *_shopAdmin;
    NSString *_shopPhone;
    NSString *_shopLogo;
    NSString *_shopAddress;
    NSString *_shopLat;
    NSString *_shopLon;
    NSString *_userFollowed;
}

@property (nonatomic, strong) NSString *idd;
@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *shopAdmin;
@property (nonatomic, strong) NSString *shopPhone;
@property (nonatomic, strong) NSString *shopLogo;
@property (nonatomic, strong) NSString *shopAddress;
@property (nonatomic, strong) NSString *shopLat;
@property (nonatomic, strong) NSString *shopLon;
@property (nonatomic, strong) NSString *userFollowed;

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (ShopInfo *)shopInfoWithDic:(NSDictionary *)dic;

@end

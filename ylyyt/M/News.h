//
//  News.h
//  afnXmltest
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
{
    NSString *_createDate;
    NSString *_newsDescribe;
    NSString *_newsPicBar;
    NSString *_shopAddress;
    NSString *_shopAdmin;
    NSString *_shopId;
    NSString *_shopLogo;
    NSString *_shopName;
    NSString *_shopPassword;
    NSString *_shopPhone;
    NSString *_linkUrl;
}

@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *newsDescribe;
@property (nonatomic, copy) NSString *newsPicBar;//
@property (nonatomic, copy) NSString *shopAddress;
@property (nonatomic, copy) NSString *shopAdmin;
@property (nonatomic, copy) NSString *shopId;
@property (nonatomic, copy) NSString *shopLogo;
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, copy) NSString *shopPassword;
@property (nonatomic, copy) NSString *shopPhone;
@property (nonatomic, copy) NSString *linkUrl;

//初始化方法
- (instancetype)initWithDic:(NSDictionary*)dic;

//工厂方法
+ (News*)newsWithDic:(NSDictionary*)dic;

@end

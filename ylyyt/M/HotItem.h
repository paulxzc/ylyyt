//
//  HotItem.h
//  afnXmltest
//
//  Created by apple on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotItem : NSObject
{
    NSString *_itemIcon;
    NSString *_itemName;
    NSString *_itemPrice;
}

@property (nonatomic, copy) NSString *itemIcon;
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *itemPrice;

//初始化方法
- (instancetype)initWithDic:(NSDictionary*)dic;

//工厂方法
+ (HotItem*)hotItemWithDic:(NSDictionary*)dic;
@end

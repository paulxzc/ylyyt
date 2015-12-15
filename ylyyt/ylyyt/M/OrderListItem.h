//
//  OrderListItem.h
//  ylyyt
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderListItem : NSObject
{
    NSString *_itemTag;
    NSString *_itemId;
    NSString *_shopId;
    NSString *_imageName;
    NSString *_shopName;
    NSString *_PinMing;
    NSString *_CanDi;
    NSString *_GuiGe;
    NSString *_DanWei;
    NSString *_PiHao;
    NSString *_ShengChanRiQi;
    NSString *_YouXiaoQi;
    NSString *_JiaGe;
    NSString *_KuChun;
}

@property (nonatomic, strong) NSString *itemTag;
@property (nonatomic, copy) NSString *itemId;
@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *PinMing;
@property (nonatomic, strong) NSString *CanDi;
@property (nonatomic, strong) NSString *GuiGe;
@property (nonatomic, strong) NSString *DanWei;
@property (nonatomic, strong) NSString *PiHao;
@property (nonatomic, strong) NSString *ShengChanRiQi;
@property (nonatomic, strong) NSString *YouXiaoQi;
@property (nonatomic, strong) NSString *JiaGe;
@property (nonatomic, strong) NSString *KuChun;

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (OrderListItem *)orderListItemWithDic:(NSDictionary *)dic;

@end

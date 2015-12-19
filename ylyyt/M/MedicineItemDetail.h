//
//  MedicineItemDetail.h
//  afnXmltest
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedicineItemDetail : NSObject
{
    NSString *_shopName;
    NSString *_imageName;
    NSString *_itemId;
    NSString *_shopId;
    NSString *_PinMing;
    NSString *_CanDi;
    NSString *_GuiGe;
    NSString *_DanWei;
    NSString *_PiHao;
    NSString *_ShengChanRiQi;
    NSString *_YouXiaoQi;
    NSString *_JiaGe;
    NSString *_KuChun;
    NSString *_itemDescribe;
}

@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, strong) NSString *PinMing;
@property (nonatomic, strong) NSString *CanDi;
@property (nonatomic, strong) NSString *GuiGe;
@property (nonatomic, strong) NSString *DanWei;
@property (nonatomic, strong) NSString *PiHao;
@property (nonatomic, strong) NSString *ShengChanRiQi;
@property (nonatomic, strong) NSString *YouXiaoQi;
@property (nonatomic, strong) NSString *JiaGe;
@property (nonatomic, strong) NSString *KuChun;
@property (nonatomic, strong) NSString *itemDescribe;

- (instancetype)initWithDic:(NSDictionary*)dic;

+ (MedicineItemDetail *)medicineItemDeatailWithDic:(NSDictionary*)dic;
@end

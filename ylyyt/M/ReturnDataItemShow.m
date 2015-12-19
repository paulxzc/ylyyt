//
//  ReturnDataItemShow.m
//  afnXmltest
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ReturnDataItemShow.h"
#import "MedicineItemDetail.h"
#import "MedicineImage.h"
#import "ShopInfoForItemShow.h"
@implementation ReturnDataItemShow



- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"item"]) {
        NSArray *items = value;
        [items enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MedicineItemDetail *medicineItemDetail = [MedicineItemDetail medicineItemDeatailWithDic:obj];
            [_it addObject:medicineItemDetail];
        }];
    }
    if ([key isEqualToString:@"image"]) {
        NSArray *images = value;
        [images enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MedicineImage *medicineImage = [MedicineImage medicineImageWithDic:obj];
            [_im addObject:medicineImage];
        }];
    }
    if ([key isEqualToString:@"shopInfo"]) {
        NSArray *shopInfos = value;
        [shopInfos enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ShopInfoForItemShow *shopInfoForItemShow = [ShopInfoForItemShow shopInfoForItemShowWithDic:obj];
            [_sh addObject:shopInfoForItemShow];
        }];
    }
  
}

//防止别人利用kvc来读取数据模型的属性，当属性不存在时，如果不重写下面的方法，程序会发生崩溃
- (id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
}


//初始化方法
- (instancetype)initWithDic:(NSDictionary*)dic{
    if (self = [super init]) {
        _it = [[NSMutableArray alloc] initWithCapacity:0];
        _im = [[NSMutableArray alloc] initWithCapacity:0];
        _sh = [[NSMutableArray alloc] initWithCapacity:0];
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

//工厂方法
+ (ReturnDataItemShow*)returnDataItemShowWithDic:(NSDictionary*)dic{
    ReturnDataItemShow *returnDataItemShow = [[ReturnDataItemShow alloc] initWithDic:dic];
    return returnDataItemShow;
}
@end

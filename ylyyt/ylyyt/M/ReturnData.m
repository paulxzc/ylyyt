//
//  ReturnData.m
//  ylyyt
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ReturnData.h"
#import "MedicineItem.h"

@implementation ReturnData


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"item"]) {
        NSArray *items = value;
        [items enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MedicineItem *medicineItem = [MedicineItem medicineItemWithDic:obj];
            [_it addObject:medicineItem];
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
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

//工厂方法
+ (ReturnData*)returnDataWithDic:(NSDictionary*)dic{
    ReturnData *returnData = [[ReturnData alloc] initWithDic:dic];
    return returnData;
}

@end

//
//  ShopInfoForItemShow.m
//  ylyyt
//
//  Created by apple on 15/11/18.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "ShopInfoForItemShow.h"

@implementation ShopInfoForItemShow

//当字典中有key，但是数据模型里面没有对应key的属性，这种情况会调用下面的方法，可以处理一些特殊情况
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _idd = value;
    }
}
//防止别人利用kvc来读取数据模型的属性，当属性不存在时，如果不重写下面的方法，程序会发生崩溃
- (id)valueForUndefinedKey:(NSString *)key{
    
    return nil;
}


- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (ShopInfoForItemShow *)shopInfoForItemShowWithDic:(NSDictionary *)dic{
    ShopInfoForItemShow *shopInfoForItemShow = [[ShopInfoForItemShow alloc] initWithDic:dic];
    return shopInfoForItemShow;
}
@end
